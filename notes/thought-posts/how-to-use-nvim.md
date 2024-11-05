---
title: How to use Nvim Configuration
author: Satvik Anand
date: 2024-11-05
---

## This document provides an overview of the features and snippets included in the Vim configuration tailored for scientific writing.

## 1. Installation Instructions

### Step 1: Install Vim-Plug

- Install Vim-Plug to manage Vim plugins.

### Step 2: Create or Edit Your Vim Configuration File

- Edit the appropriate configuration file for Vim or Neovim.

### Step 3: Install the Plugins

- Run the command to install all specified plugins after adding them to the configuration file.

## 2. Configuration Overview

### 2.1 UltiSnips Configuration

- Set up the snippet directory and configure the snippet file locations.
- Define editing configurations and triggers for snippets.
- Create a shortcut to edit snippets.

### 2.2 VimTeX Configuration

- Define the LaTeX flavor and set the preferred method for viewing compiled documents.
- Configure options for the LaTeX compiler and set up key mappings for compiling documents.

### 2.3 Markdown and Spell Check Configuration

- Enable spell check specifically for Markdown files and create a quickfix for spell suggestions.

### 2.4 File Navigation

- Configure shortcuts for toggling the file explorer (NERDTree) and using the fuzzy finder (FZF) for quick file access.

### 2.5 Additional Markdown Enhancements

- Implement custom keybindings for creating links and formatting within Markdown files.

## 3. Snippet Usage Instructions

### 3.1 General Headers and Sections

- For creating headers, use the following triggers:
  - `h1`: Creates a top-level header.
  - `h2`: Creates a second-level header.
  - `h3`: Creates a third-level header.

### 3.2 Mathematical Formatting

- For mathematical formatting, use:
  - `mk`: Inserts inline math.
  - `dm`: Creates display math.
  - `//`: Generates a fraction.

### 3.3 Chemistry Formatting

- For chemistry-related snippets, use:
  - `chem`: Creates a chemical equation.
  - `arrow`: Inserts a chemical reaction arrow.

### 3.4 Physics Formatting

- For physics formatting snippets, use:
  - `vec`: Formats a vector.
  - `unit`: Inserts units of measurement.

### 3.5 Biology Formatting

- For biology formatting, use:
  - `species`: Formats a species name.
  - `pathway`: Creates a biological pathway representation.

### 3.6 Common Scientific Notation

- For scientific notation, use:
  - `sub`: Formats text as subscript.
  - `sup`: Formats text as superscript.

### 3.7 Document Structure

- For structuring documents, use:
  - `exp`: Creates an experiment section with predefined headings.
  - `data`: Generates a structured data table.

### 3.8 References and Citations

- For citations and references, use:
  - `cite`: Inserts a citation.
  - `ref`: Creates a reference entry.

### 3.9 Enhanced Text Formatting

- For text formatting, use:
  - `bold`: Formats text in bold.
  - `ita`: Italicizes text.

### 3.10 Enhanced Lists and Tasks

- For task management, use:
  - `task`: Creates an unchecked task.
  - `taskd`: Denotes a completed task.

### 3.11 Code and Technical

- For code snippets, use:
  - `code`: Inserts a code block with specified language.

## 4. Additional Features Instructions

### 4.1 Time and Date

- For inserting the current time and date, use:
  - `date`: Inserts the current date.
  - `time`: Inserts the current time.
  - `dtime`: Inserts both date and time.

### 4.2 Graph and Diagrams

- For creating diagrams using Mermaid syntax, use:
  - `mermaid`: Inserts a Mermaid diagram.
  - `flow`: Creates a flowchart.
  - `sequence`: Generates a sequence diagram.

## 5. Key Mappings Instructions

- Use designated key mappings for:

  - Toggling Goyo (distraction-free mode) with `<leader>g`.

  - Previewing Markdown in the browser with `<leader>p`.

  - Running grammar checks with `<leader>gr`.

    ```

    ```
