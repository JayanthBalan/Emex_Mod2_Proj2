#!/bin/bash

# Expected Command Line Argument:
# out_file="./stego" bash run.bash -e cloak.bmp silent_words.txt stego_img.bmp -d stego_img.bmp uncloaked.txt
# or
# out_file="./stego" ./run.bash -e cloak.bmp silent_words.txt stego_img.bmp -d stego_img.bmp uncloaked.txt

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
    "$out_file" "-e" "${file_path}cloak.bmp" "${file_path}silent_words.txt"
}

decode_default() {
    "$out_file" "-d" "${file_path}veiled_words.bmp"
}

validate_userArguments() {

    local enc_args=()
    local dec_args=()

    if [ "$1" != "-e" ]
    then
        echo "Invalid argument syntax"
        return 1
    fi

    if [ $# -ne "${argument_cnt}" ]
    then
        echo "Insufficient arguments"
        echo "Insert all encode and decode arguments for user argument validation"
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

    if cmp -s "${file_path}silent_words.txt" "${file_path}decoded_msg.txt"
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

validate_userArguments "$@"
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
