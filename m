Return-Path: <SRS0=XoGS=LZ=canonical.com=colin.king@kernel.org>
Return-Path: <SRS0=XoGS=LZ=canonical.com=colin.king@kernel.org>
From: Colin King <colin.king@canonical.com>
Subject: [PATCH] fpga: region: fix spelling mistake "partion" -> "partition"
Date: Tue, 11 Sep 2018 13:37:32 +0100
Message-Id: <20180911123732.32579-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in the documentation

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 Documentation/devicetree/bindings/fpga/fpga-region.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index 6db8aeda461a..71beb85b56f1 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -484,7 +484,7 @@ It is beyond the scope of this document to fully describe all the FPGA design
 constraints required to make partial reconfiguration work[1] [2] [3], but a few
 deserve quick mention.
 
-A persona must have boundary connections that line up with those of the partion
+A persona must have boundary connections that line up with those of the partition
 or region it is designed to go into.
 
 During programming, transactions through those connections must be stopped and
-- 
2.17.1
