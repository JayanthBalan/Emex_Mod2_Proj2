
# Steganography

> A C command-line tool for encoding a file inside a BMP image and decoding it again.

> It works by tweaking the least significant bit of each pixel byte to sneak in your data — the image looks the same, but it's carrying a secret.

## Build

```bash
make
```

## Usage

**Hide file:**
```bash
./stego -e target_files/source_cloak.bmp target_files/source_silentWords.txt target_files/user_stegoImage.bmp
```

**Retrieve file:**
```bash
./stego -d target_files/user_stegoImage.bmp target_files/user_uncloaked.txt

```

The output filenames are optional, default files available.

## Test

```bash
out_file="./stego" bash run.bash -e source_cloak.bmp source_silentWords.txt user_stegoImage.bmp -d user_stegoImage.bmp user_uncloaked.txt
```

- Builds project
- Runs image
- Tests the program
- Compares the input encoder target file with the output decoded file

## Notes

- Target cloaking file is a BMP image
- The image is roughly 8x input file size
