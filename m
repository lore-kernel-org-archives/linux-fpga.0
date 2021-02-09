Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B39AC433E6
	for <linux-fpga@archiver.kernel.org>; Tue,  9 Feb 2021 02:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 653E664EB4
	for <linux-fpga@archiver.kernel.org>; Tue,  9 Feb 2021 02:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhBICaf (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 8 Feb 2021 21:30:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:32868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhBICac (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 8 Feb 2021 21:30:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0156964EBE;
        Tue,  9 Feb 2021 02:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612837792;
        bh=BKrAUviBBoiq9Zt7eAcPrQbB/Xha2LLwGZc0KUwrAqU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=L5TyDIxJruZIobHFPAZyw7Ac7QV2vDAU+Bs54/3i0cGrdxYm/SJRoD+lYzC2Wl2hE
         LaLCvXpjqpcIgYQf9lnaI8ptJBApNa3PdlB03Ma2oCQtl0a7F1aER3IhD46UMzU65Q
         aTJpzv2cIAozdnlBZZGHUoZte1/d3ePMpUaebTuu3tIqLRMEa5x1wF8kstjB2UBNeV
         nLpiFrz/r2zjCOG4RtMDpo1GKMzXt/1pqpueggLZ/nIS6nvqfViNN6DiVOdrMe5Z8V
         8aOBIrr3rpq8ur17xzgaPNA6USbdtWoB9Uf/r0XZd7Ex7RbGa1hYoecEjPaJ7tk7lh
         MUGgMzqgJaowg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210201151245.21845-4-alexandru.ardelean@analog.com>
References: <20210201151245.21845-1-alexandru.ardelean@analog.com> <20210201151245.21845-4-alexandru.ardelean@analog.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: clock: adi,axi-clkgen: add compatible string for ZynqMP support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, lars@metafoo.de,
        linux-fpga@vger.kernel.org, mdf@kernel.org, ardeleanalex@gmail.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 08 Feb 2021 18:29:50 -0800
Message-ID: <161283779061.76967.273651489261070815@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Quoting Alexandru Ardelean (2021-02-01 07:12:44)
> The axi-clkgen driver now supports ZynqMP (UltraScale) as well, however t=
he
> driver needs to use different PFD & VCO limits.
>=20
> For ZynqMP, these needs to be selected by using the
> 'adi,zynqmp-axi-clkgen-2.00.a' string.
>=20
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---

Applied to clk-next
