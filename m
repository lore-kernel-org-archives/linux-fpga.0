Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0EA330332
	for <linux-fpga@vger.kernel.org>; Thu,  5 Feb 2026 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770325224; cv=none; b=a6ZUcK+OBEzQ86RYqnOu4EsVPbnA/t4jFpTKaujGjEjgibO3I/lRUgThav424q6cazmP7o1rHP2ttYtooiPlbkqu1xidFxgAYNuG4zz+HORPMemaPzxmkdKmIEREme21uHZbhFMK9VO2wFq3X4PjrEEqHgrYb2ObDciRbc2qF+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770325224; c=relaxed/simple;
	bh=O9mLxT+roBXO/RmpnwI+KoBGja1TUjQ0eNURQ1PhU0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TvtG7EgztkeZ3Q0RqdOZco03qI04MNFU5oasJ3FL69OC0NwOLm7mvEygTMCng2FdGzu+zF7mHYKoN9h51IU021Newa9EnSYPHCGgzGkwPj5+GL3n80f1l3mC74Em90b/A42HNkQjWIfe1MqN+yztpDo9aM4l+6xRLr4prmN1xRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LdHqN68o; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l63Hji6B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdHqN68o";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l63Hji6B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770325223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ0fgGiJg3nMFc2XePDEX8wab9GDsnp8jWnAJ4AGTN4=;
	b=LdHqN68opCoSgzb+dsyWblg2ZcRcFHaWg/1Bq1b6STfHTwLLSWon7VzcscsFoaKt7bhuSw
	hKrpgv7xP/lTAhGbBeKVqGg+WJdc7dxUKqK5tLR7DZYs1NLKYDGFyxTsUSZN4PnqEXq5gg
	qwSGP5uIGEBHop8Th/+1wD82iAWs0dg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-p9AAztoFPlSWdcpPrcNbkQ-1; Thu, 05 Feb 2026 16:00:22 -0500
X-MC-Unique: p9AAztoFPlSWdcpPrcNbkQ-1
X-Mimecast-MFC-AGG-ID: p9AAztoFPlSWdcpPrcNbkQ_1770325222
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6a2ef071dso594078485a.0
        for <linux-fpga@vger.kernel.org>; Thu, 05 Feb 2026 13:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770325222; x=1770930022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJ0fgGiJg3nMFc2XePDEX8wab9GDsnp8jWnAJ4AGTN4=;
        b=l63Hji6BoB+gi5w9+vH+QOiMSrTaBkovo7wlFr9QrBSpNQx1PMtfiVF8aSNhSZdop1
         gHgF6SFjveuaG3P/pEhboRU7+te0EKaKX2J0Yf07V0eDTJhbBzwlPfyBzoZJ/EFX1FuK
         AAKueD239fXy8qJe418NzkqlicNjDaowWCGDsDXSeGoOuWIdpoTBbmUZP/4i5ct9KTg6
         DtQRwAyArq3F+4C23iccquX9x6DfAGXRouA1gbqLKcj6PQhc6PXrEdVIxVyh1UlBdQR2
         84Afe0bwx6eJnq1C++gyuyQeD1WfHmuPfei/7ZZqG97XyPlFWMsImB+dMCQJB80Z1+Z4
         yUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770325222; x=1770930022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aJ0fgGiJg3nMFc2XePDEX8wab9GDsnp8jWnAJ4AGTN4=;
        b=FcjQZ5DJOTPZeCbHKA8TIQ8Qt5u0lmBRwUWnjreYBzDLsyibG/aVMUwprJwvu6wqk6
         UXnEMZFnMX12iLD8df2YE+cuApGEQ6CWoVAdrCV2c2DuvynR6MM5EBNrtJc6M/IuLkrK
         e0idNQg2vuDgpBD5J693O2pOH4GHEgALpPt2+wi7yMvQXbbb+kz0Y6G1dLPvUkyG73xG
         QVHn+6dDaeBlXXEKT59rcllO0Zuzz5A7rr2iJvcuYeQV24Af23ZlADcF5OQNdq6SrMqh
         P0e1FzU+wcJUKmLHCPRqig3r9GDOgq1Kj2s+qTJT7siIcRgpMOYbH5fygA8D1u+2hDQ/
         Rp3g==
X-Forwarded-Encrypted: i=1; AJvYcCUV2APMEpshs49n360I39HZw6wAyGEE1XEBgVPEqZM2V5eUYGSONggvJpUcaQiiSZVtXWt9BqoflQAq@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7epwr1H2S6sbbS/gtEbLNRqlCs/7bK7KXrjIwsi0qUOchFz+
	J718TzPyeK2kuMyoW7xqbCNQlI1v8CRP/pm5JqY0RqlLWo/C+pKyNCt5z/rU6vYJ+0Pt2bZN/+M
	F2yzmqak10XQtd9QjWX/mo0b2se/wC+e8oVLnLf3kE1jbPcfl4cqLnGq642gz4Kk=
X-Gm-Gg: AZuq6aL6xSVA/lcMjUjvZnd1KoGlZuI6rEnW3mqPDt7bR3mu1h6f3+CEfN8MiG2syds
	OyNhPV7nmkw3I0eLA3vLZxaNH48+QCjn8go4BUaFJP5Z+GOwv9eblwmpEprdrYmC8N0fAa+HSjG
	pFf0opsC2OmlJPoyoYS5tBU+iL6+G+4l8O4BoKUb5TS1khS49vVUkXQk8Y9t4bkACTLv7u/X5Ql
	AKMW/gS8znI7JPWDGQbVyxua/KWOWmlfUS7V8AroNZI8NcxShJRDzxQz9rCQQz+afwpSYJsk0yA
	ykHyE4jXPH1/1C9AVUUGLuCD97GrE7nMiHSEyjrDQCe0tBZAzGePct5+IonXd98pJeVbenD6PEk
	PO75ds0+aD8BNhb0=
X-Received: by 2002:a05:620a:7085:b0:8b2:e70c:427a with SMTP id af79cd13be357-8caf0d3d77cmr64313685a.44.1770325221601;
        Thu, 05 Feb 2026 13:00:21 -0800 (PST)
X-Received: by 2002:a05:620a:7085:b0:8b2:e70c:427a with SMTP id af79cd13be357-8caf0d3d77cmr64305385a.44.1770325220994;
        Thu, 05 Feb 2026 13:00:20 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b010:9000:4c85:f148:4c91:943a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9fdf692sm17571285a.44.2026.02.05.13.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 13:00:20 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Thu, 05 Feb 2026 15:59:48 -0500
Subject: [PATCH v2 01/10] PCI: add driver flag to opt into disabling SR-IOV
 on remove()
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-rust-pci-sriov-v2-1-ef9400c7767b@redhat.com>
References: <20260205-rust-pci-sriov-v2-0-ef9400c7767b@redhat.com>
In-Reply-To: <20260205-rust-pci-sriov-v2-0-ef9400c7767b@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
 Moritz Fischer <mdf@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-fpga@vger.kernel.org, driver-core@lists.linux.dev, 
 Peter Colberg <pcolberg@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.2

Add a flag managed_sriov to the pci_driver structure that allows a
driver to opt into disabling the Single Root I/O Virtualization (SR-IOV)
capability of the device when the driver is unbound.

Add a new function pci_iov_disable() that is invoked before the remove()
callback of a PCI driver and checks for the presence of the new flag.
If the flag is set, invoke the sriov_configure() callback to allow the
driver to gracefully disable SR-IOV. Warn if the driver fails to do so
and forcibly disable SR-IOV using sriov_disable().

Since a (broken) driver may theoretically re-enable SR-IOV during its
remove() callback, extend pci_iov_remove() to forcibly disable SR-IOV
after remove() if needed and only if the flag managed_sriov is set.

Altogether the flag ensures that when a Virtual Function (VF) is bound
to a driver, the corresponding Physical Function (PF) is bound to a
driver, too, since the VF devices are destroyed when the PF driver is
unbound. This guarantee is a prerequisite for exposing a safe Rust
API that allows a VF driver to obtain the PF device for a VF device
and subsequently access the device private data of the PF device.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
Changes in v2:
- Move logic to disable SR-IOV on remove() from Rust to C.
- Add driver flag managed_sriov to opt into disabling SR-IOV on remove().
---
 drivers/pci/iov.c        | 41 ++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci-driver.c |  3 ++-
 drivers/pci/pci.h        |  2 ++
 include/linux/pci.h      |  8 ++++++++
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 00784a60ba80bb55ff2790d8f87e15a90c652a24..5b6ed251b4b1e940ec5781bb10dd5c58d3609fc8 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -1011,20 +1011,59 @@ void pci_iov_release(struct pci_dev *dev)
 		sriov_release(dev);
 }
 
+/**
+ * pci_iov_disable - disable SR-IOV before PF driver is detached
+ * @dev: the PCI device
+ *
+ * Invoke sriov_configure() callback to allow the driver to gracefully disable
+ * SR-IOV. Warn if the driver fails to do so and forcibly disable SR-IOV.
+ */
+void pci_iov_disable(struct pci_dev *dev)
+{
+	struct pci_driver *drv = dev->driver;
+	struct pci_sriov *iov = dev->sriov;
+
+	if (WARN_ON(!drv))
+		return;
+
+	if (!dev->is_physfn || !iov->num_VFs || !drv->managed_sriov)
+		return;
+
+	if (!drv->sriov_configure) {
+		sriov_disable(dev);
+		return;
+	}
+
+	drv->sriov_configure(dev, 0);
+
+	if (WARN_ON(iov->num_VFs))
+		sriov_disable(dev);
+}
+
 /**
  * pci_iov_remove - clean up SR-IOV state after PF driver is detached
  * @dev: the PCI device
  */
 void pci_iov_remove(struct pci_dev *dev)
 {
+	struct pci_driver *drv = dev->driver;
 	struct pci_sriov *iov = dev->sriov;
 
+	if (WARN_ON(!drv))
+		return;
+
 	if (!dev->is_physfn)
 		return;
 
 	iov->driver_max_VFs = iov->total_VFs;
-	if (iov->num_VFs)
+
+	if (iov->num_VFs && !drv->managed_sriov) {
 		pci_warn(dev, "driver left SR-IOV enabled after remove\n");
+		return;
+	}
+
+	if (WARN_ON(iov->num_VFs))
+		sriov_disable(dev);
 }
 
 /**
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 7c2d9d59625868886d61d8d4045d656ee0165776..e44593c67d147cd70d2d1a8a436a26857b0e446a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -462,6 +462,7 @@ static void pci_device_remove(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
+	pci_iov_disable(pci_dev);
 	if (drv->remove) {
 		pm_runtime_get_sync(dev);
 		/*
@@ -475,8 +476,8 @@ static void pci_device_remove(struct device *dev)
 		pm_runtime_put_noidle(dev);
 	}
 	pcibios_free_irq(pci_dev);
-	pci_dev->driver = NULL;
 	pci_iov_remove(pci_dev);
+	pci_dev->driver = NULL;
 
 	/* Undo the runtime PM settings in local_pci_probe() */
 	pm_runtime_put_sync(dev);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0e67014aa0013a7086c3a45d576d4b1ca2bb159f..53692e138ed347bfcf6d5923ddd418e9860399d7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -826,6 +826,7 @@ static inline void pci_restore_pasid_state(struct pci_dev *pdev) { }
 #ifdef CONFIG_PCI_IOV
 int pci_iov_init(struct pci_dev *dev);
 void pci_iov_release(struct pci_dev *dev);
+void pci_iov_disable(struct pci_dev *dev);
 void pci_iov_remove(struct pci_dev *dev);
 void pci_iov_update_resource(struct pci_dev *dev, int resno);
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
@@ -860,6 +861,7 @@ static inline int pci_iov_init(struct pci_dev *dev)
 	return -ENODEV;
 }
 static inline void pci_iov_release(struct pci_dev *dev) { }
+static inline void pci_iov_disable(struct pci_dev *dev) { }
 static inline void pci_iov_remove(struct pci_dev *dev) { }
 static inline void pci_iov_update_resource(struct pci_dev *dev, int resno) { }
 static inline resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b5cc0c2b99065d4a1ee4581275362e79726a2145..768a02b12ff73aeb4dc3dc33fcca7c46b524c3c0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -997,6 +997,13 @@ struct module;
  *		how to manage the DMA themselves and set this flag so that
  *		the IOMMU layer will allow them to setup and manage their
  *		own I/O address space.
+ * @managed_sriov: Disable SR-IOV on remove().
+ *		If set, the Single Root I/O Virtualization (SR-IOV)
+ *		capability of the device is disabled when the driver is
+ *		unbound from the device, by calling sriov_configure()
+ *		before remove(). The presence of this flag guarantees
+ *		that when a Virtual Function (VF) is bound to a driver,
+ *		the Physical Function (PF) is bound to a driver, too.
  */
 struct pci_driver {
 	const char		*name;
@@ -1015,6 +1022,7 @@ struct pci_driver {
 	struct device_driver	driver;
 	struct pci_dynids	dynids;
 	bool driver_managed_dma;
+	bool managed_sriov;
 };
 
 #define to_pci_driver(__drv)	\

-- 
2.52.0

