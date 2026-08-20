# Git & VS Code Guide for Product Managers

A beginner-friendly guide to version control and collaborative document editing.

---

## What Are These Tools?

### VS Code (Visual Studio Code)
Think of VS Code as a powerful text editor - like Microsoft Word, but designed for code and technical documents. You'll use it to:
- View and edit files in your repository
- See changes you've made highlighted
- Access the Terminal (command line) without leaving the app

### Git
Git is a **version control system**. Imagine Google Docs' version history, but much more powerful:
- Every change you save (called a "commit") is recorded forever
- You can see who changed what and when
- Multiple people can work on different things simultaneously
- You can always go back to previous versions

### GitHub
GitHub is where your Git repository lives online. Think of it as:
- A shared folder in the cloud that everyone on the team can access
- A backup of all your work
- A place to review and discuss changes

### Repository ("Repo")
A repository is simply a folder that Git is tracking. The `pm-workspace` folder on your computer is your **local repository**. The same folder on GitHub is the **remote repository**.

---

## Understanding the Basic Workflow

When you make changes, they go through three stages:

```
Your Edits → Staged Changes → Committed (Saved) → Pushed to GitHub
```

1. **Edit**: You change a file in VS Code
2. **Stage**: You tell Git "I want to include this change"
3. **Commit**: You save those staged changes with a description
4. **Push**: You upload your commits to GitHub so others can see them

---

## Getting Started Each Day

### Step 1: Open VS Code
- Click the VS Code icon in your Applications, or
- Open Terminal and type `code ~/Documents/pm-workspace`

### Step 2: Open the Terminal in VS Code
Press `` Ctrl+` `` (that's the backtick key, above Tab)

You'll see a command line appear at the bottom of VS Code. This is where you'll type Git commands.

### Step 3: Get the Latest Changes
Before you start working, always pull the latest version from GitHub:

```bash
git pull
```

This downloads any changes your teammates have made. **Always do this first** to avoid conflicts later.

---

## Making and Saving Changes

### Editing Files

1. **Find your file** in the sidebar (left panel) and click to open it
2. **Make your edits** - you'll see the file tab shows a dot (•) meaning unsaved
3. **Save** with `Cmd+S`

### Checking What You've Changed

After editing, run this in the Terminal:

```bash
git status
```

This shows you:
- **Red files**: Changes you've made but haven't staged yet
- **Green files**: Changes that are staged and ready to commit
- **Which branch you're on** (more on branches later)

### Saving Your Changes to Git

This is a three-step process. Run each command in order:

**Step 1 - Stage your changes** (tell Git what to include):
```bash
git add .
```
The `.` means "all changed files". You can also add specific files: `git add filename.md`

**Step 2 - Commit** (save with a description):
```bash
git commit -m "Add Q1 objectives to strategy doc"
```
The message in quotes should briefly explain what you changed and why.

**Step 3 - Push** (upload to GitHub):
```bash
git push
```

Now your changes are saved on GitHub and visible to your team.

---

## Understanding Branches

### What is a Branch?

A branch is like a parallel universe for your files. You can make changes in a branch without affecting the "main" version. This is useful when:
- You're working on something big that isn't ready yet
- You want feedback before merging into the main version
- Multiple people are working on different features

The main branch (usually called `main`) is the "official" version of your documents.

### When to Use Branches

**Use the main branch** for:
- Quick fixes and typos
- Small updates to existing documents
- Changes you're confident about

**Create a new branch** for:
- New documents or features
- Significant restructuring
- Changes you want reviewed first

### Creating and Using a Branch

```bash
# Create a new branch and switch to it
git checkout -b my-strategy-update

# ... make your changes, then stage and commit as usual ...
git add .
git commit -m "Draft new pricing strategy section"

# Push your branch to GitHub (first time only, use -u)
git push -u origin my-strategy-update
```

After pushing, go to GitHub and create a **Pull Request** (PR) to get feedback before merging.

### Switching Between Branches

```bash
# Go back to main branch
git checkout main

# Switch to an existing branch
git checkout branch-name

# See all branches
git branch
```

---

## VS Code Tips

### The Source Control Panel

Click the **branch icon** in the left sidebar (third icon down). This shows:
- All files you've changed
- A visual diff (before/after) when you click a file
- Buttons to stage, commit, and push without using Terminal

### Keyboard Shortcuts You'll Use Often

| What You Want | Keys to Press |
| --- | --- |
| Open/close Terminal | `` Ctrl+` `` |
| Save current file | `Cmd+S` |
| Search for a file by name | `Cmd+P` |
| Search inside all files | `Cmd+Shift+F` |
| Preview a Markdown file | `Cmd+Shift+V` |
| Toggle the sidebar | `Cmd+B` |

### Working with Markdown Files

Most documents in this repo use Markdown (`.md` files). Markdown is a simple way to format text:

```markdown
# Heading 1
## Heading 2
### Heading 3

**bold text**
*italic text*

- Bullet point
- Another bullet

1. Numbered item
2. Another numbered item

[Link text](https://url.com)
```

Preview your Markdown with `Cmd+Shift+V` to see how it will look on GitHub.

---

## Common Situations

### "I made a mistake and want to undo"

**If you haven't committed yet:**
```bash
# Undo changes to a specific file
git checkout filename.md

# Undo ALL uncommitted changes (be careful!)
git checkout .
```

**If you already committed:**
Ask for help - there are ways to undo commits, but they can be tricky.

### "Someone else made changes while I was working"

Run:
```bash
git pull --rebase
```
Then push your changes:
```bash
git push
```

If there's a **conflict** (you both edited the same lines), Git will ask you to resolve it. The conflicting file will show both versions - edit it to keep what you want, then:
```bash
git add .
git commit -m "Resolve merge conflict"
git push
```

### "I want to save my work but switch to something else"

Use **stash** to temporarily store your changes:
```bash
# Save current work
git stash

# Switch to another branch
git checkout other-branch

# ... do something else ...

# Come back and restore your work
git checkout original-branch
git stash pop
```

### "I want to see what changed in a file"

```bash
# See your uncommitted changes
git diff filename.md

# See the history of a file
git log --oneline filename.md
```

Or click the file in VS Code's Source Control panel to see a visual comparison.

---

## Writing Good Commit Messages

Your commit message should explain **what** you changed and **why**:

| Good Messages | Why They're Good |
| --- | --- |
| `Add competitor analysis for Q1 planning` | Clear what was added and the context |
| `Update pricing strategy based on research` | Explains the reason for the change |
| `Fix typo in product roadmap` | Simple and specific |

| Avoid These | Why They're Bad |
| --- | --- |
| `updates` | What updates? To what? |
| `changes` | Completely meaningless |
| `WIP` | What work? Still in progress? |

---

## Repository Structure

Here's how our team's repo is organised:

```
pm-workspace/
├── context/       → Background docs and context
├── data/          → Data files and analysis
├── insights/      → Research findings
├── pm-playbook/   → PM processes and templates
├── projects/      → Project-specific documentation
├── scripts/       → Automation scripts (ask before editing)
├── strategy/      → Strategy documents
└── README.md      → Overview of the repository
```

---

## Quick Reference Card

### Daily Workflow
```bash
git pull                              # Get latest changes
# ... make your edits in VS Code ...
git status                            # See what you changed
git add .                             # Stage all changes
git commit -m "Your message here"     # Save with description
git push                              # Upload to GitHub
```

### Essential Commands
| Command | What It Does |
| --- | --- |
| `git status` | Shows changed files and current branch |
| `git pull` | Downloads latest changes from GitHub |
| `git add .` | Stages all your changes |
| `git commit -m "msg"` | Saves staged changes with a message |
| `git push` | Uploads commits to GitHub |
| `git log --oneline -10` | Shows last 10 commits |

### Terminal Navigation
| Command | What It Does |
| --- | --- |
| `pwd` | Shows which folder you're in |
| `ls` | Lists files in current folder |
| `cd folder` | Goes into a folder |
| `cd ..` | Goes up one folder |
| `clear` | Clears the terminal screen |

---

## Getting Help

- **Git help**: `git help <command>` (e.g., `git help commit`)
- **GitHub Docs**: https://docs.github.com
- **VS Code Docs**: https://code.visualstudio.com/docs
- **Ask the team**: Post in Slack if you're stuck

---

*Last updated: February 2026*
