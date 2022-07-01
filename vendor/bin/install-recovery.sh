#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):102760448:f0d61948e73634b33fb04fdce1955ea1a049e269; then
  applypatch  \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):33554432:96ec2ed3f49640f310335c37d37f7a2f06b14a06 \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):102760448:f0d61948e73634b33fb04fdce1955ea1a049e269 && \
      log -t recovery "Installing new recovery image: succeeded" && \
      setprop ro.boot.recovery.updated true || \
      log -t recovery "Installing new recovery image: failed" && \
      setprop ro.boot.recovery.updated false
else
  log -t recovery "Recovery image already installed"
  setprop ro.boot.recovery.updated true
fi
