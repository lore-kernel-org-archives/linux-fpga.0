Return-Path: <SRS0=ZE+O=BO=redhat.com=trix@kernel.org>
Return-Path: <SRS0=ZE+O=BO=redhat.com=trix@kernel.org>
Subject: Re: [PATCH v3 4/4] fpga: dfl: add support for N3000 nios private
 feature
References: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
 <1596524715-18038-5-git-send-email-yilun.xu@intel.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <b5d4157b-1bdf-445c-58a7-abd2f485a5ff@redhat.com>
Date: Tue, 4 Aug 2020 11:45:33 -0700
MIME-Version: 1.0
In-Reply-To: <1596524715-18038-5-git-send-email-yilun.xu@intel.com>
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="------------917081727EA098E8963B573F"
To: Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, Russ Weight <russell.h.weight@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

This is a multi-part message in MIME format.
--------------917081727EA098E8963B573F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Some minor edits.

I have added definitions for fec, kr, and rs.

Reviewed-by: Tom Rix <trix@redhat.com>

Tom

> --- /dev/null
> +++ b/Documentation/fpga/dfl-n3000-nios.rst
> @@ -0,0 +1,39 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================
> +DFL N3000 Nios Private Feature Driver
> +=====================================
> +
> +The dfl n3000 nios driver supports for the nios handshake private feature on
> +Intel N3000 FPGA Card.
> +
> +This private feature provides a handshake interface to FPGA NIOS firmware,
> +which receives the ethernet retimer configuration command from host and
> +do the configuration via an internal SPI master. When nios finished the

does the configuration..

When nios finishes the ..

> +configuration, host takes over the ownership of the SPI master to control an
> +Intel MAX10 BMC Chip on the SPI bus.
> +
> +So the driver does 2 major tasks on probe, requires NIOS firmware to configure
, uses the NIOS firmware to configure the ethernet retimer, and then ..
> +the ethernet retimer by operating the handshake interfaces, and then creates a
> +spi master platform device with the MAX10 device info in spi_board_info.
> +
> +Module Parameters
> +=================
> +
> +The dfl n3000 nios driver supports the following module parameters:
> +
> +* fec_mode: string
> +  Require the NIOS firmware to set the FEC mode of the ethernet retimer on
the FEC (Forward Error Correction) mode
> +  the PAC N3000 FPGA card. The possible values could be:
> +
> +  - "rs": RS FEC mode (default)
- "rs" : Reed Solomon FEC (default)
> +  - "kr": KR FEC mode
- "kr": Fire Code FEC
> +  - "no": NO FEC mode
> +
> +  The configuration could only be set once after the board powers up, the
The configuration can only be ..
> +  firmware will not accept a second configuration afterward. So the fec mode
second configuration.
> +  will not be changed if the module is reloaded with a different param value.
> +
> +  The configured value of the fec mode could be queried from sysfs node:
> +
> +  /sys/bus/dfl/devices/dfl-fme.X.X/fec_mode

--------------917081727EA098E8963B573F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Some minor edits.</p>
    <p>I have added definitions for fec, kr, and rs.<br>
    </p>
    <p>Reviewed-by: Tom Rix <a class="moz-txt-link-rfc2396E" href="mailto:trix@redhat.com">&lt;trix@redhat.com&gt;</a></p>
    <p>Tom<br>
    </p>
    <blockquote type="cite"
      cite="mid:1596524715-18038-5-git-send-email-yilun.xu@intel.com">
      <pre class="moz-quote-pre" wrap="">--- /dev/null
+++ b/Documentation/fpga/dfl-n3000-nios.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+DFL N3000 Nios Private Feature Driver
+=====================================
+
+The dfl n3000 nios driver supports for the nios handshake private feature on
+Intel N3000 FPGA Card.
+
+This private feature provides a handshake interface to FPGA NIOS firmware,
+which receives the ethernet retimer configuration command from host and
+do the configuration via an internal SPI master. When nios finished the</pre>
    </blockquote>
    <p>does the configuration..</p>
    <p>When nios finishes the ..<br>
    </p>
    <blockquote type="cite"
      cite="mid:1596524715-18038-5-git-send-email-yilun.xu@intel.com">
      <pre class="moz-quote-pre" wrap="">
+configuration, host takes over the ownership of the SPI master to control an
+Intel MAX10 BMC Chip on the SPI bus.
+
+So the driver does 2 major tasks on probe, requires NIOS firmware to configure</pre>
    </blockquote>
    , uses the NIOS firmware to configure the ethernet retimer, and then
    ..<br>
    <blockquote type="cite"
      cite="mid:1596524715-18038-5-git-send-email-yilun.xu@intel.com">
      <pre class="moz-quote-pre" wrap="">
+the ethernet retimer by operating the handshake interfaces, and then creates a
+spi master platform device with the MAX10 device info in spi_board_info.
+
+Module Parameters
+=================
+
+The dfl n3000 nios driver supports the following module parameters:
+
+* fec_mode: string
+  Require the NIOS firmware to set the FEC mode of the ethernet retimer on</pre>
    </blockquote>
    the FEC (Forward Error Correction) mode<br>
    <blockquote type="cite"
      cite="mid:1596524715-18038-5-git-send-email-yilun.xu@intel.com">
      <pre class="moz-quote-pre" wrap="">
+  the PAC N3000 FPGA card. The possible values could be:
+
+  - "rs": RS FEC mode (default)</pre>
    </blockquote>
    - "rs" : Reed Solomon FEC (default)<span style="color: rgb(85, 85,
      85); font-family: intel-clear, tahoma, Helvetica, helvetica,
      Arial, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; orphans: 2; text-align:
      start; text-indent: 0px; text-transform: none; white-space:
      normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width:
      0px; background-color: rgb(243, 243, 243); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;"><br>
    </span>
    <blockquote type="cite"
      cite="mid:1596524715-18038-5-git-send-email-yilun.xu@intel.com">
      <pre class="moz-quote-pre" wrap="">
+  - "kr": KR FEC mode</pre>
    </blockquote>
    - "kr": Fire Code FEC
    <blockquote type="cite"
      cite="mid:1596524715-18038-5-git-send-email-yilun.xu@intel.com">
      <pre class="moz-quote-pre" wrap="">
+  - "no": NO FEC mode
+
+  The configuration could only be set once after the board powers up, the</pre>
    </blockquote>
    The configuration can only be ..<br>
    <blockquote type="cite"
      cite="mid:1596524715-18038-5-git-send-email-yilun.xu@intel.com">
      <pre class="moz-quote-pre" wrap="">
+  firmware will not accept a second configuration afterward. So the fec mode</pre>
    </blockquote>
    second configuration.<br>
    <blockquote type="cite"
      cite="mid:1596524715-18038-5-git-send-email-yilun.xu@intel.com">
      <pre class="moz-quote-pre" wrap="">
+  will not be changed if the module is reloaded with a different param value.
+
+  The configured value of the fec mode could be queried from sysfs node:
+
+  /sys/bus/dfl/devices/dfl-fme.X.X/fec_mode
</pre>
    </blockquote>
  </body>
</html>

--------------917081727EA098E8963B573F--
