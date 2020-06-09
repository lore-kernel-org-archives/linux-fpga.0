Date: Tue, 9 Jun 2020 08:48:02 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: [GIT PULL] FPGA Manager (late) fixes for 5.8
Message-ID: <20200609154800.GA16679@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org, moritzf@google.com
List-ID: <linux-fpga@vger.kernel.org>

The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-fixes-for-5.8

for you to fetch changes up to 6a47d6efc6931b02d10163de2fb85ec9953c4f5e:

  fpga: zynqmp: fix modular build (2020-06-09 08:27:01 -0700)

----------------------------------------------------------------
FPGA Manager fixes for 5.8-rc1

Here is one (late) fix for 5.8-rc1 merge window.

Arnd's change addresses a missing build dependency.

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of my fixes branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      fpga: zynqmp: fix modular build

 drivers/fpga/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
