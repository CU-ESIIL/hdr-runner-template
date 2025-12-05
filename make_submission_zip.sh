# Script to bundle model + requirements into a submission zip
# Prior to running this script, in bash, run 
#   `chmod +x make_submission_zip.sh`
# to make it executable. Then run it with
#   `./make_submission_zip.sh`

#!/usr/bin/env bash
set -euo pipefail

# ---- User-configurable paths ----

# Where you want the final zip to be written
my_write_path=~/data-store/home/esokol/ESIIL_hackathon_testing/

# Name of the zip file (no path, just filename)
my_zip_filename=submission_20251204_1424_runner.zip

# Paths to the three files that must go into the zip
my_path_to_requirements=~/data-store/HDR-SMood-Challenge-sample/baselines/submissions/BioClip2/requirements.txt
my_path_to_model=~/data-store/HDR-SMood-Challenge-sample/baselines/submissions/BioClip2/model.py
my_path_to_weights=~/data-store/home/esokol/ESIIL_hackathon_testing/20251204_1424_runner/model_2025-12-04_21-43-34.pth

# ---- Basic sanity checks ----

echo "Checking input files..."
for f in "$my_path_to_requirements" "$my_path_to_model" "$my_path_to_weights"; do
    if [ ! -f "$f" ]; then
        echo "ERROR: File not found: $f" >&2
        exit 1
    fi
done

if [ ! -d "$my_write_path" ]; then
    echo "ERROR: Output directory does not exist: $my_write_path" >&2
    exit 1
fi

# ---- Create the zip in the target directory ----

echo "Changing to output directory: $my_write_path"
cd "$my_write_path"

echo "Creating zip archive: $my_zip_filename"
echo "  - Using -v (verbose) to show progress"
echo "  - Using -j (junk paths) so only filenames appear in the zip"

zip -vj \
    "$my_zip_filename" \
    "$my_path_to_requirements" \
    "$my_path_to_model" \
    "$my_path_to_weights"

echo "Zip created at: $my_write_path$my_zip_filename"

# ---- Optional: list contents so you can verify ----

echo "Listing contents of the zip:"
zipinfo "$my_zip_filename"
