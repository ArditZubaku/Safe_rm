# Safe Remove Script for Zsh

## Overview
The `safe-rm.sh` script is a safety tool for Unix-like systems using the Zsh shell. It overrides the standard `rm` (remove) command to provide additional safeguards when deleting directories, especially those that are part of a Git repository. This script helps prevent accidental deletion of repositories.

## Features
- **Git Repository Detection**: Automatically detects if a directory is a Git repository.
- **Repository Details Display**: Shows the current branch and last commit message for Git repositories.
- **Deletion Confirmation**: Prompts for user confirmation before deleting Git repositories.
- **Color-Coded Warnings**: Uses colored text for better visibility of warnings and messages.

## Installation
1. Download the `safe-rm.sh` script.
2. Add the following line to your `~/.zshrc` file to source the script:

```bash
source /path/to/safe-rm.sh
```

3. Restart your terminal session or source your `~/.zshrc` file:

```bash
source ~/.zshrc
```


## Usage
Once installed, use the `rm` command as you normally would. The script will automatically invoke the `safe_rm` function when you attempt to remove any directory.

Example:

```bash
rm my_directory
```

If `my_directory` is a Git repository, you will see a detailed warning and be prompted for confirmation before deletion.

## Note
- This script was tested only in Zsh shell but since Zsh is built on top of bash this probably works on bash too.
- It only affects directories recognized as Git repositories.
- The aliasing is effective only in the shell sessions where it's sourced.
