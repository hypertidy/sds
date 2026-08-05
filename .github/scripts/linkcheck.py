#!/usr/bin/env python3
"""Link checker for the sds registry.

Reads inst/extdata/sds-registry.csv, derives a checkable URL per row by kind,
HEAD-requests each (with a GET range fallback), and writes a markdown report.

Exit status: 0 if all checked rows pass, 1 otherwise.

Usage:
  linkcheck.py [--names name1,name2]   # restrict to specific rows (PR mode)
  linkcheck.py --dry-run               # print derived URLs, no network
"""
import csv, subprocess, sys, time, os

REGISTRY = "inst/extdata/sds-registry.csv"
SOURCES_DIR = "inst/sources"
TIMEOUT = "30"

def check_url(url):
    """Return final http code as int; HEAD first, GET range fallback."""
    def curl(*extra):
        r = subprocess.run(
            ["curl", "-s", "-o", "/dev/null", "-w", "%{http_code}",
             "-L", "--max-time", TIMEOUT, *extra, url],
            capture_output=True, text=True)
        try:
            return int(r.stdout.strip() or 0)
        except ValueError:
            return 0
    code = curl("-I")
    if not (200 <= code < 400):
        code = curl("-r", "0-0")
    return code

def derive(row):
    """Return (mode, target). mode is 'url', 'file', or 'skip'."""
    url, kind = row["url"], row["kind"]
    if row.get("status", "") == "dead":
        return ("skip", "status=dead")
    if kind in ("cog", "vrt_url", "parquet", "gpkg"):
        return ("url", url)
    if kind == "zip_vector":
        i = url.find(".zip")
        return ("url", url[: i + 4] if i >= 0 else url)
    if kind == "wmts":
        u = url[len("WMTS:"):] if url.startswith("WMTS:") else url
        return ("url", u.split(",layer", 1)[0])
    if kind == "raw":
        i = url.find(":")
        u = url[i + 1:] if 0 < i < 10 else url
        return ("url", u)
    if kind in ("xml_file", "vrt_file"):
        return ("file", os.path.join(SOURCES_DIR, url))
    return ("url", url)

def main(argv):
    names = None
    dry = "--dry-run" in argv
    for a in argv:
        if a.startswith("--names"):
            names = set(a.split("=", 1)[1].split(",")) if "=" in a \
                else set(argv[argv.index(a) + 1].split(","))
    with open(REGISTRY, newline="") as f:
        rows = list(csv.DictReader(f))
    if names is not None:
        rows = [r for r in rows if r["name"] in names]

    failures, checked, skipped = [], 0, 0
    for row in rows:
        mode, target = derive(row)
        if mode == "skip":
            skipped += 1
            continue
        if dry:
            print(f"{row['name']:32s} {mode:4s} {target}")
            continue
        checked += 1
        if mode == "file":
            ok = os.path.exists(target)
            code = "present" if ok else "MISSING"
        else:
            code = check_url(target)
            ok = 200 <= code < 400
            time.sleep(0.5)
        print(f"{'ok ' if ok else 'FAIL'} {code!s:>7} {row['name']:32s} {target}")
        if not ok:
            failures.append((row["name"], row["kind"], str(code), target))

    if dry:
        return 0

    ## second pass over failures to drop transient blips
    persistent = []
    for name, kind, code, target in failures:
        if code == "MISSING":
            persistent.append((name, kind, code, target))
            continue
        time.sleep(2)
        c2 = check_url(target)
        if not (200 <= c2 < 400):
            persistent.append((name, kind, str(c2), target))

    with open("linkcheck-report.md", "w") as out:
        if persistent:
            out.write(f"{len(persistent)} of {checked} checked sources failing "
                      f"({skipped} skipped as status=dead).\n\n")
            out.write("| name | kind | code | checked url |\n|---|---|---|---|\n")
            for name, kind, code, target in persistent:
                out.write(f"| `{name}` | {kind} | {code} | {target} |\n")
            out.write("\nConfirm and set `status` to `dead` (with a successor "
                      "in `notes`) in `inst/extdata/sds-registry.csv`, or fix "
                      "the row.\n")
        else:
            out.write(f"All {checked} checked sources ok "
                      f"({skipped} skipped as status=dead).\n")
    print(open("linkcheck-report.md").read())
    return 1 if persistent else 0

if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
