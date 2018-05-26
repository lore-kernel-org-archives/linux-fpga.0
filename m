Return-Path: <SRS0=FIJW=IN=infradead.org=rdunlap@kernel.org>
Return-Path: <SRS0=FIJW=IN=infradead.org=rdunlap@kernel.org>
Subject: Re: [PATCH 09/14] Documentation: fpga: move fpga overview to
 driver-api
References: <20180516235007.3951-1-atull@kernel.org>
 <20180516235007.3951-10-atull@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4799501f-bca4-0a56-6d93-6cae844d7973@infradead.org>
Date: Fri, 25 May 2018 19:21:17 -0700
MIME-Version: 1.0
In-Reply-To: <20180516235007.3951-10-atull@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 05/16/2018 04:50 PM, Alan Tull wrote:
> Start of moving Documentation/fpga/*.txt to driver-api, including:
>  - Add new directory driver-api/fpga
>  - Add new file driver-api/fpga/index.rst
>  - Add driver-api/fpga to driver-api/index.rst
>  - Move Documentation/fpga/overview.txt to driver-api/fpga/intro.rst
>  - Formatting and rewrites so that intro.rst will build cleanly
>    and form a good introduction to the rest of the docs to be added.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
>  Documentation/driver-api/fpga/index.rst | 10 ++++++
>  Documentation/driver-api/fpga/intro.rst | 54 +++++++++++++++++++++++++++++++++
>  Documentation/driver-api/index.rst      |  1 +
>  Documentation/fpga/overview.txt         | 23 --------------
>  4 files changed, 65 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/driver-api/fpga/index.rst
>  create mode 100644 Documentation/driver-api/fpga/intro.rst
>  delete mode 100644 Documentation/fpga/overview.txt

Hi,
Just a few comments for you.

> diff --git a/Documentation/driver-api/fpga/intro.rst b/Documentation/driver-api/fpga/intro.rst
> new file mode 100644
> index 0000000..51cd81d
> --- /dev/null
> +++ b/Documentation/driver-api/fpga/intro.rst
> @@ -0,0 +1,54 @@
> +Introduction
> +============
> +
> +The FPGA subsystem supports reprogramming FPGAs dynamically under
> +Linux.  Some of the core intentions of the FPGA subsystems are:
> +
> +* The FPGA subsystem is vendor agnostic.
> +
> +* The FPGA subsystem separates upper layers (userspace interfaces and
> +  enumeration) from lower layers that know how to program a specific
> +  FPGA.
> +
> +* Code should not be shared between upper and lower layers.  This
> +  should go without saying.  If that seems necessary, there's probably
> +  framework functionality that that can be added that will benefit

                             that      can be

> +  other users.  Write the linux-fpga mailing list and maintainers and
> +  seek out a solution that expands the framework for broad reuse.

                          choose one spelling:                ^^^^vvvvv

> +* Generally, when adding code, think of the future.  Plan for re-use.
> +
> +The framework in the kernel is divided into:
> +
> +FPGA Manager
> +------------
> +
> +If you are adding a new FPGA or a new method of programming a FPGA,
> +this is the subsystem for you.  Low level FPGA manager drivers contain
> +the knowledge of how to program a specific device.  This subsystem
> +includes the framework in fpga-mgr.c and the low level drivers that
> +are registered with it.
> +
> +FPGA Bridge
> +-----------
> +
> +FPGA Bridges prevent spurious signals from going out of a FPGA or a

                                                        of an

> +region of a FPGA during programming.  They are disabled before

          of an 

> +programming begins and re-enabled afterwards.  An FPGA bridge may be
> +actual hard hardware that gates a bus to a cpu or a soft ("freeze")

                                              CPU

> +bridge in FPGA fabric that surrounds a partial reconfiguration region
> +of an FPGA.  This subsystem includes fpga-bridge.c and the low level
> +drivers that are registered with it.
> +
> +FPGA Region
> +-----------
> +
> +If you are adding a new interface to the FPGA framework, add it on top
> +of a FPGA region to allow the most reuse of your interface.

   of an

> +
> +The FPGA Region framework (fpga-region.c) associates managers and
> +bridges as reconfigurable regions.  A region may refer to the whole
> +FPGA in full reconfiguration or to a partial reconfiguration region.
> +
> +The Device Tree FPGA Region support (of-fpga-region.c) handles
> +reprogramming FPGAs when device tree overlays are applied.



-- 
~Randy
