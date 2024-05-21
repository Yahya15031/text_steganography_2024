# Text Steganography Project

## Project Description
**Text Steganography** is an Assembly program that embeds a secret message within a cover text based on a user-provided key. The application ensures that the message is hidden from plain sight and only extracts it when the correct key is provided. This method allows for secure and discreet communication.

## Features
- **Embed Secret Message**: Hides a secret message within a specified cover text.
- **Extract Secret Message**: Extracts the secret message from the cover text if the correct key is provided.
- **User Key Verification**: Only processes the embedding and extraction if the entered key matches the predefined one.

## Prerequisites
- **Windows OS**: The program is designed to run on Windows.
- **MASM**: Microsoft Macro Assembler (MASM) for compiling and running Assembly code.
- **Irvine32 Library**: Required for handling I/O and other system operations in the Assembly program.

## Setup and Installation
1. **Install MASM**: Ensure Microsoft Macro Assembler (MASM) is installed on your system. You can find installation instructions on the [Official MASM Forum](http://www.masmforum.com/).
2. **Download Irvine32 Library**: The Irvine32 Library is essential for the project. Download and setup instructions can be found on [Kip Irvine's website](http://kipirvine.com/asm/).

## How to Run
1. **Compile the Program**:
   ```bash
   ml /c /coff yourprogram.asm
## Limitations
- The program currently handles a fixed length of the secret message and key.
- It is designed to operate in a Windows environment with specific dependencies like the Irvine32 library.
