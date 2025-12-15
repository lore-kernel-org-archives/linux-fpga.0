Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FE230F534;
	Mon, 15 Dec 2025 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765825610; cv=none; b=IecLlx7mVH08+psCk7Ofl+TKW/5m2xVKgGwQqHjjusGdA767P2+oYHVg0mOy7yLQHCplCNQKSLOXznnbm0Ne1IsbBDhHCQRziYtlZxxL26GOolIXNY5CuXjeA3FcdjTpxNs1WINsxlS5C8cuIGSs9iM5OKZsysFnOeoIcF//Nvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765825610; c=relaxed/simple;
	bh=Yp26+EGzwYO1usScZJjoN9BD74C4NLYLIYytEpYsmWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C4zlQIHsyvADdcVzKtB2LhUUd8/Kwupha9i3ZgXxDnNSiq1RWJ78NdEH0tylZdyrVG3XUH+zN4VC/Oy+gDrGBaNST+dYDs/sarmi2eCIHVTpBg6e20ZKl0dU45iyrolejgq0nWjl3po7PEFnFjOs8+2FUT4GQuIH2Ry7NFQN5SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qr0eLOdp; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qr0eLOdp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QCm0YKHohscurTCFeu2NnP1fwj3ycWs1e8lY5LwXh+4=; b=qr0eLOdpEYjAuXcHENLHiRjN71
	7MrRPqnEvh1jw6u17KHWL66kVw7S//IV4g1JrmjjkbeUsSMOBPILcqFIb2piaveX68v6aOWfl1sxI
	GpnjPTai/4ZfohAARuCXaMulLiySR4TBO++gk8IhTphjW62WGcOCtvSj9D5YC8qEZ8ZBvz+Mhb+05
	0Yr2yOI5yaKnyzi/cI4PbmluriKkpcBi4ah0XZVn25IRmdcTvIBuAcg4Nha+N74OaiGJ7ZI+Ixp3D
	gnYF2xaQgwNYt1JOMl0oylzuuvPTTIOm/91K+JaEFtNJ8rx+lGonE3oCxhb+21cPr2e0C2f2uxfYf
	FQ5HZ8qg==;
Received: from [179.125.94.223] (helo=[127.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vVDu6-00D3in-F2; Mon, 15 Dec 2025 20:06:42 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Mon, 15 Dec 2025 16:05:50 -0300
Subject: [PATCH] fpga: dfl: use subsys_initcall to allow built-in drivers
 to be added
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-dfl_subsys-v1-1-21807bad6b10@igalia.com>
X-B4-Tracking: v=1; b=H4sIAA1cQGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0NT3ZS0nPji0qTiymLdFGPzZHNzIwtTU3MjJaCGgqLUtMwKsGHRsbW
 1AATgzTxcAAAA
X-Change-ID: 20251215-dfl_subsys-d37c77285572
To: Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Matthew Gerlach <matthew.gerlach@linux.intel.com>, 
 Russ Weight <russell.h.weight@intel.com>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.14.2

The dfl code adds a bus. If it is built-in and there is a built-in driver
as well, the dfl module_init may be called after the driver module_init,
leading to a failure to register the driver as the bus has not been added
yet.

Use subsys_initcall, which guarantees it will be called before the drivers
init code.

Without the fix, we see failures like this:

[    0.479475] Driver 'intel-m10-bmc' was unable to register with bus_type 'dfl' because the bus was not initialized.

Fixes: 9ba3a0aa09fe ("fpga: dfl: create a dfl bus type to support DFL devices")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/fpga/dfl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 7022657243c0a72bda2013386c66fb8bafe4b380..449c3a082e232b2814c136c7b2f36e75f2ba1aa3 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -2018,7 +2018,7 @@ static void __exit dfl_fpga_exit(void)
 	bus_unregister(&dfl_bus_type);
 }
 
-module_init(dfl_fpga_init);
+subsys_initcall(dfl_fpga_init);
 module_exit(dfl_fpga_exit);
 
 MODULE_DESCRIPTION("FPGA Device Feature List (DFL) Support");

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251215-dfl_subsys-d37c77285572

Best regards,
-- 
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

