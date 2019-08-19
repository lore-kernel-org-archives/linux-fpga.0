Date: Sun, 18 Aug 2019 17:47:46 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: [GIT PULL] FPGA Manager (late) change for 5.3-rc6
Message-ID: <20190819004744.GA20155@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ tags/fpga-fixes-for-5.3

for you to fetch changes up to dec43da46f63eb71f519d963ba6832838e4262a3:

  fpga: altera-ps-spi: Fix getting of optional confd gpio (2019-08-18 17:40:02 -0700)

----------------------------------------------------------------
FPGA Manager fixes for 5.3

A single fix for the altera-ps-spi driver that fixes the behavior when
the driver receives -EPROBE_DEFER when trying to obtain a GPIO desc.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Phil Reid (1):
      fpga: altera-ps-spi: Fix getting of optional confd gpio

 drivers/fpga/altera-ps-spi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)
