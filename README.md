# ⚙️ CCS Build GitHub Action

This GitHub Action builds TI Code Composer Studio (CCS) projects using the command-line interface inside a Docker container.

## ✅ Features

- Uses CCS 20.5.1 preinstalled in a container
- Initializes workspace
- Auto-imports project
- Builds one or more configurations

## 📦 Usage

```yaml
- name: Checkout code
  uses: actions/checkout@v6

- name: Build with CCS
  uses: orace/ccsbuild@v0.5
  with:
    product_family: c28
    project_path: path/to/the/project
    configurations: Debug;Release
