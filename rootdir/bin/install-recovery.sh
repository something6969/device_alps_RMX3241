#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):134217728:69fda971fd0f870438dacf36787596c13a6fa860; then
  applypatch  \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):33554432:78a288d65ca7554d25aa23704ac34f1e074dab8e \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):134217728:69fda971fd0f870438dacf36787596c13a6fa860 && \
      log -t recovery "Installing new recovery image: succeeded" && \
      setprop ro.boot.recovery.updated true || \
      log -t recovery "Installing new recovery image: failed" && \
      setprop ro.boot.recovery.updated false
else
  log -t recovery "Recovery image already installed"
  setprop ro.boot.recovery.updated true
fi
