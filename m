Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E583C3BE1
	for <linux-fpga@vger.kernel.org>; Tue,  3 Mar 2026 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572538; cv=none; b=HO2Wx/W3WK+LRZfpN8ANfC2UaGzConrGyFnH9NT8Hrrg+tuRB5Rvme+L8ellzpuMy3FRhktzbkyo+vCJDcsQHXVHp+OIotSXsJKYYE8V/RS6gbAPRbVTd8d+DxsFf+n2pbYz2FCx23+3x1jfpuq7i1WQGRkTlptCpKlFl58+zD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572538; c=relaxed/simple;
	bh=ax5r1OmCHwEBpaIwBxT5kM3++FSx0BGrf1GkfVvAo60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i66IzZJavYVZnrt7HY2MAx5L64qOZhgtir6Sj7Bxq5ZktAl4dKaRoBFRLdm8ZYJ5VWE1o7g6l6t61zl4mxkKzxYVfGA94gE6SW00bdPeKbvrYhH7R5GTAI23kMYa8ah2zohQZxNKnvySBJDfzG7jEJBLUA5hO/Mz8N03KyUcE84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KsqeXmYs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PeEwA98N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsqeXmYs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeEwA98N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772572535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0eBeiZqE9TXbxZv4w/1cPbOmShRF2lMY9/B+OMDvXLw=;
	b=KsqeXmYs19oLNt/fKJR7xlLsjGxnkv4I1zH5KRXnkBUMVtH3uYfG7fRyVNBuVRaM6X/JYv
	yDA0wLzt7atqZCgePy9cpkqrD7Ub3cEYBGaDmOfnQbkZZPKa9d5/i9/DBYL/NNnrG2/VIv
	9PycSl8bzR2mDBkessw0HQIWcJkZ/YA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-FsxClLaCOC2VgqoU-v09Xw-1; Tue, 03 Mar 2026 16:15:35 -0500
X-MC-Unique: FsxClLaCOC2VgqoU-v09Xw-1
X-Mimecast-MFC-AGG-ID: FsxClLaCOC2VgqoU-v09Xw_1772572534
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50333a8184aso645011571cf.1
        for <linux-fpga@vger.kernel.org>; Tue, 03 Mar 2026 13:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772572534; x=1773177334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eBeiZqE9TXbxZv4w/1cPbOmShRF2lMY9/B+OMDvXLw=;
        b=PeEwA98NBIn4s+Qxxwt/N2rAyTcDdnE73fnBttGH6L/6q5mSeDiaa//hfBP6OzfKkM
         UHfgX1zGVdHKwWjMhNwmu6AgGOFYYq7V4SgYDEyAUaVuQyjX+Oaz3ouzLERDN9xAaYBR
         E389rm7ni2SgMpNz68n5aognENtXYBg9ouapAFxM/e4RDwDc7a9LX+8j8FV6Cff5DnbM
         qQoq4KgOylFYo55kGXno7bSz8tcvRoqUhhDw32377b0JQVOQbmfwDhnTzGJFuHXMa5rI
         bw0VZAZJ6+NIMNePczAR07URhIINgt4yBeaGMhzU7GsYnZQYznfur4pY9pW1OdlDNurX
         creA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572534; x=1773177334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0eBeiZqE9TXbxZv4w/1cPbOmShRF2lMY9/B+OMDvXLw=;
        b=v2100zYiSTKB5x+UEswojJTQ4u0eD0kQxxyqswCalj/Q2IueUwqK8H16DTnOkviNmK
         COe7cUY0bJfF3QjKgKvgLt0MjdY5d8k0qv870oNrzP/Dgq6RfbrsLHSW1lyIEqIIrPMT
         A1uUe1PP5uPHmfnC/9K88b5uHaJtASbe4o+WABXTjN54doE3VBYGLPt5UODyFX25bR3N
         KBr0cS3pD5alF6B0R2Y01o55ZegolTYVnjyOmrW8kjlxMWx9wyXi8lZ/UJtjxySfPPJK
         kn7lNtyTrwcDmGQySqtFws2Dv9sP/IUpsAd2TrcOzseLvgSgQH2zNCBoMu+VPf2mWyI0
         yQJg==
X-Forwarded-Encrypted: i=1; AJvYcCWwmWahWtBV1CZzHtW1UM8eEFzghFkjBrxX8LnBn6yHPMQ52lWxEs2Mg+5pGo/x53nmNiYlSdiDKYXM@vger.kernel.org
X-Gm-Message-State: AOJu0YxUaeYjHqBAhsRB1etvvAXbHhOOOHGRRkKhjjaTuN9Aei26XwYG
	ZB+CYRk2HLt+0YpL+CAckA/q8qK/QbB71r204IB8GkjrrUa85z65dA8ToLeRdfDlripVSDjSNRd
	jme3/t8TdtcoZucrtdu997dXS6QHeDuqmn0Nd05dbI6cAeP1Sv2OXM8fzorHDB5k=
X-Gm-Gg: ATEYQzw2qm1Fvzd5bB4JGcHWXrec4r1eZb8E1godmJxrvJoI145jXoMOA7pBN7X802R
	wdKy9oU4p1NMOGhUjGhtXsYwOQfvhkVl1vOBhn+P282pI5gjMrZ6Jbe4spiGLAQsLcxGukx4qC1
	u2BVGxcMvSYNrrx2lqvpM/hvI5g453rz4QyTcMlf68w0AvdFZWc2l0Zn/wZ/D5T30yCt18/uhQ7
	YhjvP7cMsysrKwuFoHcpBhif/mi3T87Ap3LUcOTQw6bWELkkO4BUYhs53XHD6yXGLjH0Rj1mAAy
	5QYyXQ60/tLDdoiFRkwOoXMgvxQCiTp+s24yQxCWU5LbOzrhPs089VXoe9oytxB1148Uikyfcge
	JOcVFvJymNmxQm1uiT/UKIV6N2A==
X-Received: by 2002:ac8:5f8f:0:b0:506:a1a8:c6fb with SMTP id d75a77b69052e-507528765a2mr213886661cf.2.1772572534160;
        Tue, 03 Mar 2026 13:15:34 -0800 (PST)
X-Received: by 2002:ac8:5f8f:0:b0:506:a1a8:c6fb with SMTP id d75a77b69052e-507528765a2mr213886271cf.2.1772572533578;
        Tue, 03 Mar 2026 13:15:33 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b1e3:9a00:3c7:56c2:f819:96d2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5074481c0e5sm156286991cf.0.2026.03.03.13.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:15:33 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Tue, 03 Mar 2026 16:15:21 -0500
Subject: [PATCH v3 01/10] PCI: add driver flag to opt into disabling SR-IOV
 on remove()
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-rust-pci-sriov-v3-1-4443c35f0c88@redhat.com>
References: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>
In-Reply-To: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
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
 Moritz Fischer <mdf@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Boqun Feng <boqun@kernel.org>
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
index 91ac4e37ecb9c0c5265aa40c235e84b430f43a96..da64d6ce5d30de8a52089b36fcb013937cf8b6fe 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -1010,20 +1010,59 @@ void pci_iov_release(struct pci_dev *dev)
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
index dd9075403987d84e068014b35745e8872e93fdae..3fe43711565a3eb61a06cc3700e5ca953961fbe9 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -491,6 +491,7 @@ static void pci_device_remove(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
+	pci_iov_disable(pci_dev);
 	if (drv->remove) {
 		pm_runtime_get_sync(dev);
 		/*
@@ -504,8 +505,8 @@ static void pci_device_remove(struct device *dev)
 		pm_runtime_put_noidle(dev);
 	}
 	pcibios_free_irq(pci_dev);
-	pci_dev->driver = NULL;
 	pci_iov_remove(pci_dev);
+	pci_dev->driver = NULL;
 
 	/* Undo the runtime PM settings in local_pci_probe() */
 	pm_runtime_put_sync(dev);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 13d998fbacce6698514d92500dfea03cc562cdc2..66308f5126ff9e4bebb537a541f1dd8717bccbfa 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -943,6 +943,7 @@ static inline void pci_restore_pasid_state(struct pci_dev *pdev) { }
 #ifdef CONFIG_PCI_IOV
 int pci_iov_init(struct pci_dev *dev);
 void pci_iov_release(struct pci_dev *dev);
+void pci_iov_disable(struct pci_dev *dev);
 void pci_iov_remove(struct pci_dev *dev);
 void pci_iov_update_resource(struct pci_dev *dev, int resno);
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
@@ -977,6 +978,7 @@ static inline int pci_iov_init(struct pci_dev *dev)
 	return -ENODEV;
 }
 static inline void pci_iov_release(struct pci_dev *dev) { }
+static inline void pci_iov_disable(struct pci_dev *dev) { }
 static inline void pci_iov_remove(struct pci_dev *dev) { }
 static inline void pci_iov_update_resource(struct pci_dev *dev, int resno) { }
 static inline resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d512301de4d462fe7e5097c32af5c6f8d..859f767b30f726bd157a6080f5977c17c4827a1d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1015,6 +1015,13 @@ struct module;
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
@@ -1033,6 +1040,7 @@ struct pci_driver {
 	struct device_driver	driver;
 	struct pci_dynids	dynids;
 	bool driver_managed_dma;
+	bool managed_sriov;
 };
 
 #define to_pci_driver(__drv)	\

-- 
2.53.0

