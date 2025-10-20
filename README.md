# PromptBox - Alfred Workflow

An Alfred workflow that lets you quickly run custom LLM prompts using OpenAI's API.

## Features

- 🔍 **Quick Search**: Find and run prompts with fuzzy search
- 📋 **Clipboard Integration**: Run prompts with clipboard content as input
- ⚡ **Fast Access**: Trigger prompts with a simple keyword (`p`)
- ✏️ **Easy Management**: Edit your prompt collection in any text editor
- 📝 **Structured Output**: View formatted responses directly in Alfred

## Installation

1. Download and install the workflow in Alfred
2. Configure your OpenAI API key:
   - Open Alfred Preferences → Workflows
   - Select "PromptBox"
   - Click the `[x]` button in the top right
   - Enter your OpenAI API key

## Usage

### Running Prompts

1. Activate Alfred and type `p` followed by your search query
2. Select a prompt from the list
3. Two options:
   - **Press ↩**: Run the prompt with custom input
   - **Press ⌘ + ↩**: Run the prompt with clipboard content as input
4. View the AI response in the text view
5. **Press ⌘ + ↩** again to copy the output to clipboard

### Editing Prompts

Type `prompts edit` in Alfred to open your prompts file for editing.

## Prompt File Format

Prompts are stored in `prompts.txt` using a simple markdown-like format:

```markdown
## Prompt Title

Your prompt instructions here.
This can be multiple lines.

## Another Prompt

Instructions for another prompt.
```

Each prompt section:
- Starts with `##` followed by the prompt title
- Contains the instructions/system prompt on the following lines
- Sections are separated by blank lines

### Example Prompts

```markdown
## Summarize

Summarize the following text in 2-3 sentences, focusing on the key points.

## Fix Grammar

Fix any grammar, spelling, or punctuation errors in the text. Maintain the original tone and style.

## Translate to Spanish

Translate the following text to Spanish. Keep the tone and meaning intact.

## Code Review

Review this code for potential bugs, performance issues, and best practices. Provide specific suggestions.
```

## Author

Created by [Radoslav Stankov](https://github.com/RStankov)

## Repository

[https://github.com/RStankov/PromptBox](https://github.com/RStankov/PromptBox)
