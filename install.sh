#!/bin/bash
#Version:1.0
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
	echo -e "*     6. 退出程序                  *"
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

					cp -r /Volumes/$number/EFI /Users/$(users)/Desktop/backups/EFI

					cp -r EFI /Volumes/$diskname/

					 

				;;
			4)
				echo -e "请输入分区号"
				read number
				sudo diskutil umount /dev/$number
				;;
			5)
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
				
					

				;;
			4)
				echo -e "请输入分区号"
				read number
				sudo diskutil umount /dev/$number
				;;
			5)
				exit -1
				;;
		esac						
	done
}

function install_wifi()
{
	sh ar956x-drv-osx/ar956x-inst.sh
}


logo

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
		exit -1
		;;
esac

