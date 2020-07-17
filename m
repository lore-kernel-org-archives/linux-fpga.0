Date: Fri, 17 Jul 2020 16:44:09 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: [GIT PULL] FPGA Manager (late) fixes for 5.8
Message-ID: <20200717234408.GA4556@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org, moritzf@google.com, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

The following changes since commit 11ba468877bb23f28956a35e896356252d63c983:

  Linux 5.8-rc5 (2020-07-12 16:34:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git fpga-late-fixes-for-5.8

for you to fetch changes up to 8614afd689df59d9ce019439389be20bd788a897:

  fpga: dfl: fix bug in port reset handshake (2020-07-13 22:11:17 -0700)

----------------------------------------------------------------
FPGA manager fixes for 5.8

Here are two (late) dfl fixes for the the 5.8 release.

Matthew's fix addresses an issue in the reset of a port.

Xu'x fix addresses a linter warning.

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of my fixes branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Matthew Gerlach (1):
      fpga: dfl: fix bug in port reset handshake

Xu Yilun (1):
      fpga: dfl: pci: reduce the scope of variable 'ret'

 drivers/fpga/dfl-afu-main.c | 3 ++-
 drivers/fpga/dfl-pci.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)
