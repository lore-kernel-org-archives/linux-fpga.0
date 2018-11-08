Return-Path: <SRS0=W2pA=NU=gmail.com=capetry.dev@kernel.org>
Return-Path: <SRS0=W2pA=NU=gmail.com=capetry.dev@kernel.org>
From: capetry.dev@gmail.com
Subject: [PATCH 2/2] fpga: altera-cvp: Fix function definition argument
Date: Wed,  7 Nov 2018 23:13:12 -0200
Message-Id: <20181108011312.29587-3-capetry.dev@gmail.com>
In-Reply-To: <20181108011312.29587-1-capetry.dev@gmail.com>
References: <20181108011312.29587-1-capetry.dev@gmail.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

From: Carlos A Petry <capetry.dev@gmail.com>

Fix the following checkpatch warning:
WARNING: function definition argument 'struct altera_cvp_conf *'

Signed-off-by: Carlos A Petry <capetry.dev@gmail.com>

---
 drivers/fpga/altera-cvp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 45b7c8c0b..150a9f5dd 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -66,7 +66,8 @@ struct altera_cvp_conf {
 	struct fpga_manager	*mgr;
 	struct pci_dev		*pci_dev;
 	void __iomem		*map;
-	void			(*write_data)(struct altera_cvp_conf *, u32);
+	void			(*write_data)(struct altera_cvp_conf *conf,
+					      u32 data);
 	char			mgr_name[64];
 	u8			numclks;
 };
-- 
2.17.1
