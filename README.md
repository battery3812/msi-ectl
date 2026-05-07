# msi-ectl
MSI Embedded Controller Control Center for Linux-based systems

msi-ectl is a CLI-based shell script that allows users to control 
the MSI Embedded Controller on Linux systems.

**This project would not have been possible without the work of 
BeardOverflow, the maintainer of msi-ec**

**https://github.com/BeardOverflow/msi-ec**

# Purpose
I created this script to make Linux more accessible for MSI users 
migrating from Windows and other operating systems. MSI's official software, Dragon Center and 
MSI Center, are Windows-only applications. Linux users who want to 
control hardware features like Cooler Boost, fan modes, and battery 
settings have historically had no straightforward solution.

msi-ectl aims to fill that gap with a simple, lightweight shell 
script that requires no desktop environment, and no dependencies beyond 
the msi-ec kernel module

# Requirements
- msi-ec kernel module
- git
- make
- dkms (optional but recommended)
- Kernel headers for your running kernel

# Usage
sudo ./msi-ectl.sh

# License
GNU General Public License v2.0
