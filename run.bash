#!/bin/bash

# Expected Command Line Argument:
# out_file="./stego" bash run.bash -e source_cloak.bmp source_silentWords.txt user_stegoImage.bmp -d user_stegoImage.bmp user_uncloaked.txt
# or
# out_file="./stego" ./run.bash -e source_cloak.bmp source_silentWords.txt user_stegoImage.bmp -d user_stegoImage.bmp user_uncloaked.txt

if [[ -z "$out_file" ]]
then
    out_file="./stego"
fi

argument_cnt=7
file_path="target_files/"

encode_userArguments() {
    "$out_file" "$@"
}

decode_userArguments() {
    "$out_file" "$@"
}

encode_default() {
    "$out_file" "-e" "${file_path}source_cloak.bmp" "${file_path}source_silentWords.txt"
}

decode_default() {
    "$out_file" "-d" "${file_path}default_veiledWords.bmp"
}

validate_userArguments() {

    local enc_args=()
    local dec_args=()

    if [ "$1" != "-e" ] || [ "$5" != "-d" ]
    then
        echo "Invalid argument syntax"
        return 1
    fi

    local status=0

    for arg in "$@"
    do
        if [ "$arg" = "-d" ]
        then
            status=1
        fi

        if [ "$status" -eq 0 ]
        then
            enc_args+=("$arg")
        else
            dec_args+=("$arg")
        fi
    done

    encode_userArguments "${enc_args[@]}" || return 1
    decode_userArguments "${dec_args[@]}" || return 1

    if cmp -s "$3" "$7"
    then
        echo "userArguments: Input and Output files evaluated."
        echo "userArguments: Both files matched. Message encode and decode success."
    else
        echo "userArguments: Input and Output files do not match"
        echo "userArguments: Fail"
        return 1
    fi

    return 0
}

validate_default() {

    encode_default || return 1
    decode_default || return 1

    if cmp -s "${file_path}source_silentWords.txt" "${file_path}default_decodedMessage.txt"
    then
        echo "default: Input and Output files evaluated."
        echo "default: Both files matched. Message encode and decode success."
    else
        echo "default: Input and Output files do not match"
        echo "default: Fail"
        return 1
    fi

    return 0
}

proc_args=()

if [ $# -eq 1 ] && [ "$1" = "clean" ]
then
    echo "Cleanse target_files"
    rm -f "${file_path}default_veiledWords.bmp" "${file_path}user_stegoImage.bmp" "${file_path}"user_uncloaked.*
    exit 0
elif [ $# -eq "${argument_cnt}" ]
then
    proc_args+=("$1")
    proc_args+=("${file_path}$2")
    proc_args+=("${file_path}$3")
    proc_args+=("${file_path}$4")
    proc_args+=("$5")
    proc_args+=("${file_path}$6")
    proc_args+=("${file_path}$7")
else
    echo "Insufficient arguments"
    echo "Insert all encode and decode arguments for user argument validation"
    exit 1
fi

make clean
make || exit 1

validate_userArguments "${proc_args[@]}"
if [ $? -ne 0 ]
then
    echo "run: Script Failed"
    exit 1
fi

validate_default
if [ $? -ne 0 ]
then
    echo "run: Script Failed"
    exit 1
fi

echo "run: Successfully tested Steganography project"
exit 0
