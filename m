Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557BE34FF5D
	for <linux-fpga@vger.kernel.org>; Mon,  8 Jun 2026 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936994; cv=none; b=Oj4ytpSITdofhLey2xYC7iGGVsw5oZf8pWJB0K4AKECuzjkQ+BN2+XN79Ue9GGFRjqJH54Z3s4GxC3viIu7THqnmrdCOeye07A70RSYt81o7+9+P68i77FFMPiQAY2ZnM9hsFc6PXoereBmw2lkJcVJMXBxZH/cfZ1u0QB+AAU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936994; c=relaxed/simple;
	bh=1nyOZvA2AvEWQimh3Gfm62Ba12AY+b6MEMgaYa6ZaL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O+eiuMW4o0nWX+5j2ANeUnKQAedtDrW3UZA07XL1YyOMc5pvFDVe7rTULJJmYbnzXmyjq4clNtOY70LhqbblhwxW7kPT8hv8zUJ4Mlx+yTvLJiSGnfpK49hvRgR7lxfcVQJ9H4arG5coOdFHghQN0L10ls0NyUeWtLN2mkN1YEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AjRCjDbE; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AjRCjDbE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780936989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W6/65yEzaHQo8OCNtb5IfYBY2UawPbsFP/1BVZCP6iU=;
	b=AjRCjDbEZP6EUmmCJjpggMyf2AOPMgxBPtdUoZCS18kjnYNeFhMM6bFcMlxYcuYffGmNhV
	xr503yRki2d97pI/xw/WH9zj7Yyg4Jq07N/GGDjroycMDehluAtbbR1N3x4cPvji3exCdh
	GgODpFDW7VN6zBaXMyf8i0+++hVsq+Q=
From: Marco Pagani <marco.pagani@linux.dev>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Marco Pagani <marco.pagani@linux.dev>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] fpga: region: Add support for FPGA region variants
Date: Mon,  8 Jun 2026 18:42:45 +0200
Message-ID: <20260608164247.1998417-1-marco.pagani@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This RFC proposes a proof-of-concept implementation of FPGA region
variants, a mechanism that introduces a common way to handle
dynamic partial reconfiguration from userspace. The proposed approach
is safe and aligned with the mainline kernel's stance on hardware
management by constraining the hardware to a mutually exclusive set
of configurations (variants) defined upfront. This is a realistic
assumption for FPGAs, as regions are typically statically defined and
synthesized during the system design phase. To keep the architecture
realistic, the following additional constraints are introduced:
(i) variants cannot be nested, and (ii) variants cannot contain FPGA
bridges.

The interface and core logic for the variant mechanism are defined
in the fpga-region and implemented in a backwards-compatible way.
The fpga-region now optionally exports sysfs attributes that allow
the user to reconfigure a region that supports variants by selecting
one variant a list of pre-defined variants. Concrete regions can enable
variant support by implementing the new apply_variant and remove_variant
methods and adding them to fpga_region_info before registration.

As part of this RFC, the of-fpga-region concrete region has been extended
to implement the variant interface. Variants are statically specified in
the device tree using an fpga-variants node. Additionally, it introduces
a firmware-cached property to cache bitstreams in memory, enabling a fast
reconfiguration path for real-time (latency-sensitive) applications.

Below is an example of how variants can be statically defined in the
device tree under this architecture:

fake_mgr: fpga-mgr@0 {
        compatible = "linux,fake-fpga-mgr";
};

fpga_region: fpga-region@0 {
        compatible = "fpga-region";
        #address-cells = <2>;
        #size-cells = <2>;
        ranges;

        /* FPGA region properties */
        fpga-mgr = <&fake_mgr>;
        partial-fpga-config;
        region-unfreeze-timeout-us = <10000>;

        /* Base variant */
        base-variant = "variant-1";

        /* Variants container node */
        fpga-variants {
                #address-cells = <2>;
                #size-cells = <2>;
                ranges;

                variant-1 {
                        firmware-name = "variant1-image.bin";

                        #address-cells = <2>;
                        #size-cells = <2>;
                        ranges;

                        variant_1_ip: ip_1@10000 {
                                compatible = "fake,ip_1";
                                reg = <0x0 0x10000 0x0 0x1000>;
                        };
                };

                variant-2 {
                        firmware-name = "variant2-image.bin";
                        firmware-cached;

                        #address-cells = <2>;
                        #size-cells = <2>;
                        ranges;

                        variant_2_ip: ip_2@10000 {
                                compatible = "fake,ip_2";
                                reg = <0x0 0x20000 0x0 0x1000>;
                        };
                };
        };
};

Marco Pagani (2):
  fpga: region: Add support for FPGA region variants
  fpga: of-fpga-region: Add support for region variants

 drivers/fpga/fpga-region.c       | 171 +++++++++++++++++++
 drivers/fpga/of-fpga-region.c    | 272 ++++++++++++++++++++++++++++++-
 include/linux/fpga/fpga-region.h |  32 ++++
 3 files changed, 473 insertions(+), 2 deletions(-)

-- 
2.54.0

