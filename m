Return-Path: <SRS0=IFE+=BO=analog.com=alexandru.Ardelean@kernel.org>
Return-Path: <SRS0=IFE+=BO=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 4/6] clk: axi-clkgen: Respect ZYNQMP PFD/VCO frequency limits
Date: Tue, 4 Aug 2020 14:06:56 +0300
Message-ID: <20200804110658.40911-5-alexandru.ardelean@analog.com>
In-Reply-To: <20200804110658.40911-1-alexandru.ardelean@analog.com>
References: <20200804110658.40911-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mturquette@baylibre.com, sboyd@kernel.org, mdf@kernel.org, Mathias Tausen <mta@gomspace.com>, Alexandru Ardelean <alexandru.ardelean@analog.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Mathias Tausen <mta@gomspace.com>

Since axi-clkgen is now supported on ZYNQMP, make sure the max/min
frequencies of the PFD and VCO are respected.

Signed-off-by: Mathias Tausen <mta@gomspace.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 14d803e6af62..6ffc19e9d850 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -100,10 +100,17 @@ static uint32_t axi_clkgen_lookup_lock(unsigned int m)
 	return 0x1f1f00fa;
 }
 
+#ifdef ARCH_ZYNQMP
+static const unsigned int fpfd_min = 10000;
+static const unsigned int fpfd_max = 450000;
+static const unsigned int fvco_min = 800000;
+static const unsigned int fvco_max = 1600000;
+#else
 static const unsigned int fpfd_min = 10000;
 static const unsigned int fpfd_max = 300000;
 static const unsigned int fvco_min = 600000;
 static const unsigned int fvco_max = 1200000;
+#endif
 
 static void axi_clkgen_calc_params(unsigned long fin, unsigned long fout,
 	unsigned int *best_d, unsigned int *best_m, unsigned int *best_dout)
-- 
2.17.1
