Return-Path: <SRS0=ipgG=KP=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=ipgG=KP=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:36664 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732274AbeGaRLu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 31 Jul 2018 13:11:50 -0400
Received: by mail-it0-f50.google.com with SMTP id p81-v6so4951220itp.1
        for <linux-fpga@vger.kernel.org>; Tue, 31 Jul 2018 08:30:59 -0700 (PDT)
MIME-Version: 1.0
From: fei phung <feiphung27@gmail.com>
Date: Tue, 31 Jul 2018 23:30:58 +0800
Message-ID: <CAF8QhUgrkjp01eFwTpq2Qn9Hi=-1K_ts-beCMd1DgnbtCOV-LA@mail.gmail.com>
Subject: pthread, ioctl and kthread
Content-Type: multipart/alternative; boundary="000000000000c3a95805724d432c"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-fpga@vger.kernel.org

--000000000000c3a95805724d432c
Content-Type: text/plain; charset="UTF-8"

How does pthread_create()
<https://github.com/promach/riffa/blob/full_duplex/c_c%2B%2B/linux/x64/test_apps/testutil.c#L182-L215>
calling fpga_ioctl()
<https://github.com/promach/riffa/blob/full_duplex/driver/linux/riffa_driver.c#L1011-L1027>
which call kthread_run()
<http://www.cs.fsu.edu/%7Ecop4610t/lectures/project2/kthreads/kthreads.pdf#page=4>
appear to you guys ?

Remember, the code modification work I had done in the github repo
<https://github.com/promach/riffa/tree/full_duplex> is for transforming the
code from half-duplex to full-duplex, thus the use of threads.

Could anyone help ? Thanks !!!

--000000000000c3a95805724d432c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">How does <a href=3D"https://github.com/promach/riffa/blob/=
full_duplex/c_c%2B%2B/linux/x64/test_apps/testutil.c#L182-L215" rel=3D"nofo=
llow" target=3D"_blank">pthread_create()</a> calling <a href=3D"https://git=
hub.com/promach/riffa/blob/full_duplex/driver/linux/riffa_driver.c#L1011-L1=
027" rel=3D"nofollow" target=3D"_blank">fpga_ioctl()</a> which call <a href=
=3D"http://www.cs.fsu.edu/%7Ecop4610t/lectures/project2/kthreads/kthreads.p=
df#page=3D4" rel=3D"nofollow" target=3D"_blank">kthread_run()</a> appear to=
 you guys ?<br>
<br>
Remember, the <a href=3D"https://github.com/promach/riffa/tree/full_duplex"=
 rel=3D"nofollow" target=3D"_blank">code modification work I had done in th=
e github repo</a> is for transforming the code from half-duplex to full-dup=
lex, thus the use of threads.<br>
<br>
Could anyone help ? Thanks !!!<br></div>

--000000000000c3a95805724d432c--
