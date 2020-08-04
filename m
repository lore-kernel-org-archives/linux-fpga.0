Return-Path: <SRS0=IFE+=BO=analog.com=alexandru.Ardelean@kernel.org>
Return-Path: <SRS0=IFE+=BO=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/6] clk: axi-clkgen: Set power bits for fractional mode
Date: Tue, 4 Aug 2020 14:06:54 +0300
Message-ID: <20200804110658.40911-3-alexandru.ardelean@analog.com>
In-Reply-To: <20200804110658.40911-1-alexandru.ardelean@analog.com>
References: <20200804110658.40911-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mturquette@baylibre.com, sboyd@kernel.org, mdf@kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Alexandru Ardelean <alexandru.ardelean@analog.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Lars-Peter Clausen <lars@metafoo.de>

Using the fractional dividers requires some additional power bits to be
set.

The fractional power bits are not documented and the current heuristic
for setting them seems be insufficient for some cases. Just always set all
the fractional power bits when in fractional mode.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 1df03cc6d089..14d803e6af62 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -37,6 +37,7 @@
 #define MMCM_REG_LOCK1		0x18
 #define MMCM_REG_LOCK2		0x19
 #define MMCM_REG_LOCK3		0x1a
+#define MMCM_REG_POWER		0x28
 #define MMCM_REG_FILTER1	0x4e
 #define MMCM_REG_FILTER2	0x4f
 
@@ -320,6 +321,7 @@ static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
 	struct axi_clkgen *axi_clkgen = clk_hw_to_axi_clkgen(clk_hw);
 	unsigned int d, m, dout;
 	struct axi_clkgen_div_params params;
+	uint32_t power = 0;
 	uint32_t filter;
 	uint32_t lock;
 
@@ -331,6 +333,11 @@ static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
 	if (d == 0 || dout == 0 || m == 0)
 		return -EINVAL;
 
+	if ((dout & 0x7) != 0 || (m & 0x7) != 0)
+		power |= 0x9800;
+
+	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_POWER, power, 0x9800);
+
 	filter = axi_clkgen_lookup_filter(m - 1);
 	lock = axi_clkgen_lookup_lock(m - 1);
 
-- 
2.17.1
