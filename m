Return-Path: <SRS0=ek6B=K5=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=ek6B=K5=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:39167 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbeHNHKE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 14 Aug 2018 03:10:04 -0400
MIME-Version: 1.0
From: fei phung <feiphung27@gmail.com>
Date: Tue, 14 Aug 2018 12:24:31 +0800
Message-ID: <CAF8QhUiCOpbUjzkA_HF+6kFtRTFM254b+Q=AV5QjcJeXTWuDfQ@mail.gmail.com>
Subject: riffa linux driver modification with round-robin scheduling
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-fpga@vger.kernel.org, linux-c-programming@vger.kernel.org

For https://paste.ubuntu.com/p/FvgjPns75v/ (modified riffa_driver.c) ,
why am I having the following error: invalid use of undefined type
=E2=80=98struct sched_param=E2=80=99 ?

I have included
https://github.com/promach/riffa/blob/full_duplex/driver/linux/riffa_driver=
.c#L55-L59
(sched.h header)

I am trying to make
https://github.com/promach/riffa/blob/full_duplex/driver/linux/riffa_driver=
.c#L1011-L1027
(this un-modified riffa_driver.c) scheduled with round-robin policy

Note: For the riffa_driver.c, please refer to the ubuntu paste.
Mailing list receivers do not generally favour inline posting of long
code.

>phung@UbuntuHW15:~/Documents/fpga_overlay/riffa/driver/linux$ make clean &=
& make debug
> rm -Rf *.ko *.cmd *.o *.so *.so.* .*.cmd Module.symvers Module.markers mo=
dules.order *.mod.c .tmp_versions
> Compiling driver for kernel: 4.17.4-041704-generic with the following val=
ues
>      NAME: 'riffa'
>    MAJNUM: '100'
> VENDOR_ID0: '10EE'
> VENDOR_ID1: '1172'
>
> sed -i 's/#define MAJOR_NUM [^\n]*/#define MAJOR_NUM 100/g' riffa_driver.=
h
> sed -i 's/#define DEVICE_NAME [^\n]*/#define DEVICE_NAME "riffa"/g' riffa=
_driver.h
> sed -i 's/#define VENDOR_ID0 [^\n]*/#define VENDOR_ID0 0x10EE/g' riffa_dr=
iver.h
> sed -i 's/#define VENDOR_ID1 [^\n]*/#define VENDOR_ID1 0x1172/g' riffa_dr=
iver.h
> sed -i 's/#define DEBUG [^\n]*/#define DBUG 1/g' riffa_driver.h
> sed -i 's/#define DBUG [^\n]*/#define DEBUG 1/g' riffa_driver.h
> make -C /lib/modules/`uname -r`/build SUBDIRS=3D`pwd` modules
> make[1]: Entering directory '/usr/src/linux-headers-4.17.4-041704-generic=
'
>   CC [M]  /home/phung/Documents/fpga_overlay/riffa/driver/linux/riffa_dri=
ver.o
> /home/phung/Documents/fpga_overlay/riffa/driver/linux/riffa_driver.c: In =
function =E2=80=98chnl_recv=E2=80=99:
> /home/phung/Documents/fpga_overlay/riffa/driver/linux/riffa_driver.c:601:=
12: error: invalid use of undefined type =E2=80=98struct sched_param=E2=80=
=99
>   recv_param.sched_priority =3D 1;
>             ^
> /home/phung/Documents/fpga_overlay/riffa/driver/linux/riffa_driver.c: In =
function =E2=80=98chnl_send=E2=80=99:
> /home/phung/Documents/fpga_overlay/riffa/driver/linux/riffa_driver.c:831:=
12: error: invalid use of undefined type =E2=80=98struct sched_param=E2=80=
=99
>   send_param.sched_priority =3D 1;
>             ^
> /home/phung/Documents/fpga_overlay/riffa/driver/linux/riffa_driver.c: At =
top level:
> /home/phung/Documents/fpga_overlay/riffa/driver/linux/riffa_driver.c:133:=
27: error: storage size of =E2=80=98recv_param=E2=80=99 isn=E2=80=99t known
>  static struct sched_param recv_param;
>                            ^~~~~~~~~~
> /home/phung/Documents/fpga_overlay/riffa/driver/linux/riffa_driver.c:134:=
27: error: storage size of =E2=80=98send_param=E2=80=99 isn=E2=80=99t known
>  static struct sched_param send_param;
>                            ^~~~~~~~~~
> scripts/Makefile.build:312: recipe for target '/home/phung/Documents/fpga=
_overlay/riffa/driver/linux/riffa_driver.o' failed
> make[2]: *** [/home/phung/Documents/fpga_overlay/riffa/driver/linux/riffa=
_driver.o] Error 1
> Makefile:1577: recipe for target '_module_/home/phung/Documents/fpga_over=
lay/riffa/driver/linux' failed
> make[1]: *** [_module_/home/phung/Documents/fpga_overlay/riffa/driver/lin=
ux] Error 2
> make[1]: Leaving directory '/usr/src/linux-headers-4.17.4-041704-generic'
> Makefile:94: recipe for target 'riffa.ko' failed
> make: *** [riffa.ko] Error 2
>
> phung@UbuntuHW15:~/Documents/fpga_overlay/riffa/driver/linux$
