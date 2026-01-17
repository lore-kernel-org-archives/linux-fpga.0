Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379CA18C02E;
	Sat, 17 Jan 2026 04:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768624595; cv=none; b=F7Zx4j7otDiI45VPKD2YCUj7q5M1Xza2NtcM/eV7voAD50eZZlRLRS139wSM15gzViSWvVyz3t/+n4cFMe0M7uaKnR2MNprj19XofoqVxwuy3AYJ2vba8p9pwWwz1WWdbwRjvCWkpN44b8bQhtW/4FKh0swhU7AwdmhHalVJuv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768624595; c=relaxed/simple;
	bh=nRaqPqSI1GrKN3qAiiJkdMl0aYlIWMrSnIsy8sr27aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n74LUysK66YKcI4MVI3LDLyLibWzGR4g2bBYATQOOnGhX5+avPdlrorHkk36a/DZ7lAs7+AsoxmNy4k/KiaTu6qh07FKloTTcs6AgUHRfjoW4bCQXHDrZhZVG++fMTjhw/gW3JARzTxWjuctO5V7tKTSDUuP/uDYzzSDS/36PTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRQIA1ZX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRQIA1ZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC71C4CEF7;
	Sat, 17 Jan 2026 04:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768624594;
	bh=nRaqPqSI1GrKN3qAiiJkdMl0aYlIWMrSnIsy8sr27aw=;
	h=From:To:Cc:Subject:Date:From;
	b=lRQIA1ZXQhuB/tpc10xuWCjqP5VLnAAlm/azl118Ugen2W4CXpmAfX15MtNAdpJxm
	 9SFjLwfrFv4Y/74hHditL3J+KZx6jEBD91dcDwBxAKWWCk3KosSFQg104c+nyB5Sg5
	 tQFxC3xJBzCM9PZvwNQQ6m3b/bEO37mJdWezEofubnFbuA2cbwtGdw5kPfVjEDqAFU
	 TbWmpYlBiBaVFt0ly0ZTskJLVzmRQ2TWdfFXivBb4qPh7J6G7Yp4o2IppdN8V4Pk0p
	 T4LJmyEfWW/B+fPiQ5B+jHQYYMdJ12stlSlRBIWsPlxSTJmJcT/BWscvjkj0S/9Gu8
	 sf3guUroQAEPw==
From: Dinh Nguyen <dinguyen@kernel.org>
To: mdf@kernel.org,
	yilun.xu@intel.com,
	trix@redhat.com
Cc: dinguyen@kernel.org,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: bridge: Use sysfs_emit() instead of sprintf()
Date: Fri, 16 Jan 2026 22:36:26 -0600
Message-ID: <20260117043626.2188219-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Documentation/filesystems/sysfs.rst, show() functions
should use sysfs_emit() when formatting the value to be returned to user
space.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/fpga/fpga-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 8ef395b49bf8..d0d28d5f6112 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -290,7 +290,7 @@ static ssize_t name_show(struct device *dev,
 {
 	struct fpga_bridge *bridge = to_fpga_bridge(dev);
 
-	return sprintf(buf, "%s\n", bridge->name);
+	return sysfs_emit(buf, "%s\n", bridge->name);
 }
 
 static ssize_t state_show(struct device *dev,
-- 
2.42.0.411.g813d9a9188

