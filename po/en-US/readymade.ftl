prev = Previous
next = Next

unknown-os = Unknown OS

parttype-root = Filesystem root ({$path})
parttype-extendedboot = Extended Boot Loader Partition ({$path})
parttype-esp = EFI System Partition ({$path})
parttype-home = User data ({$path})
parttype-var = Variable data ({$path})
parttype-other = Custom partitioning mountpoint


page-welcome = Welcome to {$distro}
page-welcome-desc = You may try {$distro} or start the installation now.
page-welcome-try = Try
page-welcome-install = Install
# v0.2.7: alpha warning — current version wipes entire disk.
page-welcome-alpha-warning = This alpha version of {$distro} only installs by ERASING the entire disk. There is no option to keep Windows or another system. Back up your files first. Dual-boot lands in v0.3.

page-failure = Installation Failure
page-failure-close = Close
page-failure-bug = Report a bug

page-language = Language
page-language-search-lang = Search Language/Locale…
page-language-next = Next

page-completed = Complete
page-completed-desc =
    {$distro} has been installed.

    Before rebooting, REMOVE the USB pendrive. If you reboot with it still plugged in, the installer will open again instead of your installed {$distro}.

    On reboot, you'll create your user and start using the system.
# v0.2.7: gate "removed pendrive" — Reboot only enabled when checked.
page-completed-pendrive-check = I have removed the pendrive from USB
page-completed-close = Close
page-completed-reboot = Reboot

page-destination = Destination
page-destination-scanning = Scanning Disks
page-destination-wait = Waiting for os-prober…
page-destination-no-disk = No Disks Found
page-destination-no-disk-desc = There are no disks suitable for installation.

page-installdual = Dual Boot
page-installdual-otheros = Other OS

page-confirmation = Confirmation
# v0.2.7: red box + "type ERASE" gate — final defense against data loss.
page-confirmation-erase-title = I will erase EVERYTHING on {$disk}
page-confirmation-erase-desc =
    Every photo, document, program, Windows account inside it. There is no undo after clicking.

    <b>To confirm, type the word ERASE (uppercase) below.</b>
page-confirmation-erase-placeholder = type: ERASE
# EXACT keyword the user must type. Localize per language and never machine-translate
# blindly — wrong word here is a footgun.
page-confirmation-erase-keyword = ERASE
page-confirmation-problem-device-mounted = {$dev} is mounted on {$mountpoint}. Unmount it to proceed.
page-confirmation-problem-devblkopen = The block-device <tt>{$dev}</tt> is in use by the following processes:
    <tt>{$pids}</tt>
    These processes must be closed before the installer can proceed. 

dialog-confirm-warn-efipartfound-title = EFI Partition Detected
dialog-confirm-warn-efipartfound-desc = If you are installing alongside another system, please ensure its EFI partition does not exist on the destination disk.
    The selected destination disk contains an EFI partition which will be erased and reformatted during the installation, causing the systems registered in it unbootable. This action is irreversible.

page-installation = Installation
page-installation-welcome-desc = Get to know your new operating system.
page-installation-help = Need help?
page-installation-help-desc = Ask in one of our chats!
page-installation-contrib = Contribute to {$distro}
page-installation-contrib-desc = Learn how to contribute your time, money, or hardware.
page-installation-progress = Installing base system...

page-installcustom = Custom Installation
page-installcustom-title = Partitions and Mountpoints
page-installcustom-desc = { $num } { $num ->
    [one] definition
    *[other] definitions
}
page-installcustom-tool = Open partitioning tool
page-installcustom-add = Add a new definition/row

page-installationtype = Installation Type
page-installationtype-entire = Entire Disk
page-installationtype-tpm = Enable TPM
page-installationtype-encrypt = Enable disk encryption
page-installationtype-chromebook = Chromebook
page-installationtype-dual = Dual Boot
page-installationtype-custom = Custom

dialog-installtype-encrypt = Disk Encryption
dialog-installtype-encrypt-desc = Please set the disk encryption password.
    If you lose the password, your data will not be recoverable.
dialog-installtype-password = Password
dialog-installtype-repeat = Repeat Password
dialog-installtype-cancel = Cancel
dialog-installtype-confirm = Confirm

installtype-edit-mp = Edit mountpoint
installtype-rm-mp = Remove mountpoint

dialog-mp-part = Partition
dialog-mp-at = Mount at
dialog-mp-opts = Mount options

installtype-parttool = Select your partitioning tool

stage-extracting = Extracting files
stage-copying = Copying files
stage-mkpart = Creating partitions and copying files
stage-initramfs = Regenerating initramfs
stage-grub = Generating system grub defaults
stage-grub1 = Generating stage 1 grub.cfg in ESP...
stage-grub2 = Generating stage 2 grub.cfg in /boot/grub2/grub.cfg...
stage-biosgrub = Installing BIOS Grub2
stage-kernel = Reinstalling kernels
stage-selinux = Setting SELinux labels

err-no-bios = Cannot detect /sys/firmware/efi, and the distribution disabled BIOS support.

# Privacy manifesto (Orbit Linux addition — affirms identity, not configuration)
page-privacy = Privacy
page-privacy-title = Your data stays here
page-privacy-desc-1 = {$distro} learns from how you use your computer. Everything it learns stays on this machine — never sent to the cloud, never seen by anyone but you.
page-privacy-desc-2 = You can audit and delete everything {$distro} learned about you, at any moment. By installing {$distro}, you acknowledge this is how it works.
page-privacy-accept = I understand

# Bento cards (slideshow during installation — Orbit Linux addition)
bento-learn-title = It learns. You stay private.
bento-learn-desc = {$distro} adapts to how you work — and everything it learns about you stays on this machine. No cloud, no telemetry.
bento-rollback-title = It cannot brick itself.
bento-rollback-desc = Every system update is reversible. If something breaks, {$distro} rolls back automatically. You'll never lose work to a bad update.
bento-organize-title = It organizes for you.
bento-organize-desc = Open your editor, terminal, and browser — {$distro} arranges them by what you're doing. Focus mode kicks in when you need it.
