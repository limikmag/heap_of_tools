# Making USB Media on Linux (based on https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux page)
1. Find your device in command:

```bash
$ lsblk
sdb                                             8:16   1  14.4G  0 disk  
├─sdb1                                          8:17   1     2G  0 part  
└─sdb2                                          8:18   1   2.4M  0 part
```
1. Make sure that the device is not mounted. First, use the findmnt device command and the device name you found in the earlier steps. For example, if the device name is sdb, use the following command: 

```bash
findmnt /dev/sdb
```

2. If the command displays no output, you can proceed with the next step. However, if the command does provide output, it means that the device was automatically mounted and you must unmount it before proceeding. A sample output will look similar to the following:


```bash
findmnt /dev/sdb
TARGET   SOURCE   FSTYPE  OPTIONS
/mnt/iso /dev/sdb iso9660 ro,relatime
```

3. Note the TARGET column. Next, use the umount target command to unmount the device: 

```bash
umount /mnt/iso
```

4. Use the dd command to write the installation ISO image directly to the USB device:

```bash
dd if=/image_directory/image.iso of=/dev/device bs=blocksize
```

5. Replace /image_directory/image.iso with the full path to the ISO image file you downloaded, device with the device name as reported by the dmesg command earlier, and blocksize with a reasonable block size (for example, 512k) to speed up the writing process. The bs parameter is optional, but it can speed up the process considerably. 

6.  Make sure to specify the output as the device name (for example, /dev/sda), not as a name of a partition on the device (for example, /dev/sda1).
For example, if the ISO image is located in /home/testuser/Downloads/rhel-server-7-x86_64-boot.iso and the detected device name is sdb, the command will look like the following: 

```bash
sudo dd if=/home/testuser/Downloads/rhel-server-7-x86_64-boot.iso of=/dev/sdb bs=512k
```

7. Wait for dd to finish writing the image to the device. Note that no progress bar is displayed; the data transfer is finished when the # prompt appears again. After the prompt is displayed, log out from the root account and unplug the USB drive. The USB drive is now ready to be used as a boot device
