Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 07/14] fpga: bridge: kernel-doc fixes
Date: Wed, 16 May 2018 18:50:00 -0500
Message-Id: <20180516235007.3951-8-atull@kernel.org>
In-Reply-To: <20180516235007.3951-1-atull@kernel.org>
References: <20180516235007.3951-1-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Fix the following warnings when documentation is built:

./drivers/fpga/fpga-bridge.c:143: warning: Function parameter or
member 'info' not described in 'fpga_bridge_get'

./drivers/fpga/fpga-bridge.c:1: warning: no structured comments found

Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/fpga-bridge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 164eb55..4b207a7 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -121,6 +121,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
 /**
  * fpga_bridge_get - get an exclusive reference to a fpga bridge
  * @dev:	parent device that fpga bridge was registered with
+ * @info:	fpga manager info
  *
  * Given a device, get an exclusive reference to a fpga bridge.
  *
-- 
2.7.4
