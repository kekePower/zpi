#!/usr/bin/zsh

function zrep_fpath_2() {
    local base_dir="${1}"

    # Ensure globbing finds dotfiles and nullglob avoids empty directory issues
    setopt local_options dotglob nullglob

    # Check if the base directory exists
    if [[ ! -d "${base_dir}" ]]; then
        echo "Error: Base directory '${base_dir}' does not exist."
        return 1
    fi

    # Iterate over directories within $base_dir with exactly one character
    for one_char_dir in ${base_dir}/?; do
        # Check if it's indeed a directory
        [[ -d "${one_char_dir}" ]] || continue

        # Recursively find all final directories under one_char_dir with the pattern first_letter/author/script
        for script_dir in ${one_char_dir}/*/*(/); do
            local script_name=$(basename "${script_dir}")
            local matching_files=("${script_dir}/${script_name}")

            # Check if there's at least one file matching the script directory's name
            if (( ${#matching_files} )); then
                echo "${script_dir}"
            fi
        done
    done
}

zrep_fpath_2 /home/stig/.zrep

