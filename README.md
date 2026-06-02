# Uriel
                                                   
A small personal project of mine, in attempt to make it easier to transfer my personal terminal habits to other systems. Attempted to make it as simple as possible to be able to git clone and run and it just work. Will be adjusting on and off to continue fixing it to my liking.

The following is the exact order to do all commands because I am a dunce and cannot remember all of this off the top of my head. Currently works for MacOS, Arch, Fedora, and Debian/Ubuntu bases. Don't have much of an interest of adding more but might in all my tinkering.

<br><br><br>

### Step 1: Clone the Repository Infrastructure
→ Pull the custom framework straight from GitHub into your home directory:
```bash
git clone https://github.com/yourusername/uriel.git ~/uriel```
```

<br>

### Step 2: Enter the Project Root Workspace
→ Navigate directly into the deployment directory:
```bash
cd ~/uriel
```

<br>

### Step 3: Authorize Execution Rights on the Core Script
→ Grant the operating system clearance to run the automation engine:
```bash
chmod +x setup.sh
```

<br>

### Step 4: Execute the Unified Automation Framework
→ Launch the master setup script to handle package provisioning, theme compilation, font loading, and configuration linking:
```bash
./setup.sh
```

<br>

### Step 5: Transition the Active Terminal Profile to ZSH
→ Swap your active runtime shell session over to your fully configured ZSH environment:
```bash
zsh
```

<br>

### Step 6: Lock in ZSH as the Native System Default Shell
→ Update your system user profile details so new terminal panes boot into ZSH automatically:
```bash
chsh -s $(which zsh)
```
