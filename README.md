# msi-ectl
MSI Embedded Controller Control Center for Linux-based systems

***CRITICAL: This project is still being actively maintained and audited for software bugs***
***It has not been proven to be stable across most Linux distributions yet***

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

In order to **install the msi-ec module** below are the requirements:
- git
- make
- dkms (optional but recommended)
- Kernel headers for your running kernel

# Usage
sudo ./msi-ectl.sh

# Testing

While I was making this project, I've realized that testing may be more complicated than ordinary
projects, because this script relies on MSI-EC, which requires MSI hardware. So I've added 
a variable "MSI_DIR" that represents where the MSI-EC module directory should be. This variable can
be changed to a directory pretending to be the MSI-EC module directory to make testing on non-MSI
hardware somewhat possible. However, testing on real MSI hardware is always better than mock-testing.

*The mock-testing approach tests the functionality of the script rather than that of the MSI-EC module.*

As of right now, the priority testing distributions are **those new Linux users are most likely to
move to (beginner distributions).**

# License
GNU General Public License v2.0

