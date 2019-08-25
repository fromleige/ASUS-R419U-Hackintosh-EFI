#!/bin/bash
#Version:2.0
#Author:fromleige

function logo()
{
	echo -e "************************************"
	echo -e "* 欢迎来到R419U 黑果EFI界面安装界面*"
	echo -e "*     1. 安装EFI到本分区及备份     *"
	echo -e "*     2. 删除EFI及转回             *"
	echo -e "*     3. 安装无线网卡工具          *"
	echo -e "*     4. 删除备份环境              *"
	echo -e "*     5. 删除EFI现环境             *"
	echo -e "*     6. 安装蓝牙驱动及修复缓存    *"
	echo -e "*     7. 退出程序                  *"
	echo -e "************************************"
}

function install_mod()
{
	while true
	do
		echo -e "欢迎来到安装EFI阶段"
		echo -e "请输入以下命令"
		echo -e "1.查看分区"
		echo -e "2.挂载分区"
		echo -e "3.安装EFI及备份"
		echo -e "4.卸载EFI分区"
		echo -e "5. 退出程序"
		read number
		case $number in 
			1)
			   sudo diskutil list
				;;
			2)
				echo -e "请输入分区号"
				read number
				sudo diskutil mount /dev/$number

				;;
			3)
					echo -e "安装EFI界面"
					echo -e "列出EFI分区号标记"
					ls -al /Volumes/
					echo -e "请输入分区号"
					read number
					echo -e "请输入分区名"
					read diskname
					mkdir /Users/$(users)/Desktop/backups

					cp -r /Volumes/$diskname/EFI /Users/$(users)/Desktop/backups/EFI

					version=$(sw_vers -productVersion) 
					echo "自动选择版本"
					if [ $version == "10.14.6" ];
					then
						cp -r Version/10.14.6/EFI /Volumes/$diskname 
					fi

					echo "安装EFI成功"

				;;
			4)
				echo -e "请输入分区号"
				read number
				sudo diskutil umount /dev/$number
				;;
			5)
				echo "退出程序"
				exit -1
				;;
		esac						
	done
}

function remove_mod()
{

	while true
	do
		echo -e "欢迎来到安装EFI阶段"
		echo -e "请输入以下命令"
		echo -e "1.查看分区"
		echo -e "2.挂载分区"
		echo -e "3.删除EFI及备份"
		echo -e "4.卸载EFI分区"
		echo -e "5. 退出程序"
		read number
		case $number in 
			1)
			   sudo diskutil list
				;;
			2)
				echo -e "请输入分区号"
				read number
				sudo diskutil mount /dev/$number

				;;
			3)
					echo -e "安装EFI界面"
					echo -e "列出EFI分区号标记"
					ls -al /Volumes/
					echo -e "请输入分区名"
					read diskname

					rm -rf /Volumes/$diskname/EFI
					cp -r /Users/$(users)/Desktop/backups/EFI /Volumes/$diskname
				
					echo "删除EFI成功"

				;;
			4)
				echo -e "请输入分区号"
				read number
				sudo diskutil umount /dev/$number
				echo "取消挂载成功"
				;;
			5)
				echo "退出程序"
				exit -1
				;;
		esac						
	done
}

function install_wifi()
{
	echo "正在安装ar956x系列网卡"
	sh ar956x-drv-osx/ar956x-inst.sh
	echo "安装成功"
}

function install_BT()
{
	echo "正在安装蓝牙驱动中"
	mv /System/Library/Extension/IOBluetoothFamily.kext /System/Library/Extension/IOBluetoothFamily.kext.bak
	cp -r Bluetooth_Driver/System/IOBluetoothFamily.kext /System/Library/Extension
	cp -r Bluetooth_Driver/Other/* /Library/Extension 
	echo "安装成功，正在修复缓存中"
	sudo rm -rf /System/Library/Caches/com.apple.kext.caches/Startup/kernelcache
	sudo rm -rf /System/Library/PrelinkedKernels/prelinkedkernel
	sudo touch /System/Library/Extensions && sudo touch /Library/Extensions && sudo kextcache -u /
	echo "修复缓存成功,请手动重启" 
}


while true  #此循环一直循环界面
do
	logo #这是命令行界面

	#这是安装界面的代码循环
	read  number

	case $number in
		1)
			install_mod
			;;
		2)
			remove_mod
			;;
		3)
			install_wifi
			;;
		4)
			rm -rf /Users/$(users)/Desktop/backups/*
			rmdir /Users/$(users)/Desktop/backups
			;;
	
		5)
			rm -rf /Users/$(users)/Desktop/backups/*
			;;
		
		6)
			install_BT
			;;
		7)	
			exit -1
			;;
	esac
done

