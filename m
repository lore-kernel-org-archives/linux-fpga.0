Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A10223BD1D;
	Tue,  7 Jul 2026 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417204; cv=none; b=YRF5tKHRKG+24ZxSKi98DH4uD2BNxO74uaE1ZudA907h+QV6vrXetLdAPXIbyIJ71QjelonA6yzWD0xjHttqQ9DuMyWmkWi+2mCmUoodTtsy3VqKlzgwk22inXUW/2r+ceBwlXPUcrSJZ7YHwyuLeUcSO777ZtuhdOTzZN61yQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417204; c=relaxed/simple;
	bh=YGg1BcLTPFV6RN3D8+fSsxINq+QBX6t8/eJbzCLKRRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBkq2pe710okSbcR4u8LoBDpucV8KzWqSvR/K92O0Zfur4AXSVPH3Kw6TrH247lJR6sDp8wqg4QyPR2V5gokJ/H3nNsOPGAci+MBwWhMJOmCWudBnhz/qnH4qSG3CEZffJABk4pwQBl0QKYl93I12M/KILKsiui8zQaY89wvBbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=iB2QvJXr; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="iB2QvJXr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XdYHUpabhxFqH9NCRW/HLTE/ahyQjh76eWpGW18QMg4=; b=iB2QvJXreBXwqTcq3OST0PNM8t
	BkuOKhFQct9Ay2yUiLBE0iUd2Q0DQ5wju6yAgqTOEnAZZf4RvOxSA2nt+ucd5r/WOlpLsP1wWOkT/
	gCcLqyzMrOESl0WXaPuWlAODOlH5aVUjGMaOFGZv/Ae0skO0qxveJXfvcsdeLlh8LCj3UuvQB2W/Q
	ft2MqWVTKVc/9cW0wLGbf7yh0uLFMZCHw5s0Mzw+goOdslbsO19/yFS2uTEZ5oglApME0/Cc5iAIc
	MA2W7PaJikBqueYl2YKWcw1DVVSOdPVOGnASmZPot41qm8HhQxDxgokmFjrayM6BZP05A/+yaBmO5
	5Q0+5Wrw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1wh2HX-000OLl-1q;
	Tue, 07 Jul 2026 11:39:59 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1wh2HX-000JZt-2M;
	Tue, 07 Jul 2026 11:39:59 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 1/1] fpga: of-fpga-region: use dev_err_probe for probe deferral
Date: Tue, 07 Jul 2026 11:39:58 +0200
Message-ID: <3710268.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20260420102136.333673-1-alexander.stein@ew.tq-group.com>
References: <20260420102136.333673-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: Clear (ClamAV 1.4.3/28053/Tue Jul  7 08:24:37 2026)

Hi,

Am Montag, 20. April 2026, 12:21:35 CEST schrieb Alexander Stein:
> This also adds a message about probe deferral.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

any feedback on this patch?

Thanks and best regards,
Alexander

> ---
>  drivers/fpga/of-fpga-region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index caa091224dc54..41e6da296cb3e 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -405,7 +405,7 @@ static int of_fpga_region_probe(struct platform_devic=
e *pdev)
>  	/* Find the FPGA mgr specified by region or parent region. */
>  	mgr =3D of_fpga_region_get_mgr(np);
>  	if (IS_ERR(mgr))
> -		return -EPROBE_DEFER;
> +		return dev_err_probe(dev, -EPROBE_DEFER, "FPGA manager not found\n");
> =20
>  	region =3D fpga_region_register(dev, mgr, of_fpga_region_get_bridges);
>  	if (IS_ERR(region)) {
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


