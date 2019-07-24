Date: Tue, 23 Jul 2019 22:20:14 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: [GIT PULL] FPGA Manager fix for 5.3
Message-ID: <20190724052012.GA3140@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fixes-for-5.3

for you to fetch changes up to c3aefa0b8f54e8c7967191e546a11019bc060fe6:

  fpga-manager: altera-ps-spi: Fix build error (2019-07-23 17:29:17 -0700)

----------------------------------------------------------------
FPGA Manager fixes for 5.3

Hi Greg,

this is only one (late) bugfix for 5.3 that fixes a build error,
when altera-ps-spi is built as builtin while a dependency is built as a
module.

This has been on the list for a while and I've reviewed it.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
YueHaibing (1):
      fpga-manager: altera-ps-spi: Fix build error

 drivers/fpga/Kconfig | 1 +
 1 file changed, 1 insertion(+)
