Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9C0C4332B
	for <linux-fpga@archiver.kernel.org>; Tue,  9 Feb 2021 02:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B905D64EB4
	for <linux-fpga@archiver.kernel.org>; Tue,  9 Feb 2021 02:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhBICak (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 8 Feb 2021 21:30:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:32922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230490AbhBICaj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 8 Feb 2021 21:30:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CD7164EA4;
        Tue,  9 Feb 2021 02:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612837798;
        bh=JsoBSP5lpEfcl1y8Jl3JJKhKT6U7+SMfidTRaeg7Orw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=d9o6kLmkshEn29It3ZrlLggGGu5qMobaptp487aFLz5qPi5KqVrj96JO+1bNeMrfS
         xzEl6vUTKS5nm+xUikiX2ygMqTK2/wvvCK6kdL88kFMfQsvxil64gxcSIc1fMXPdCX
         +bm+sIY0vRHwWccHYH8Xf/JDXKN3Q3YyxyRZL+LwsHKSOz+dkqn7eZTHBOqUlyUyGf
         GshZ0HxmYk6k8vHJpTJxXjwQfxZvdaSskWLD2v41Hby+pztNAmfG5Ard8jusm4Uytd
         4HY7L/yUKDKZgguRU5tT+n9rOWJBfPQNaqZWwHzwpY72OoLgCvOTnirEoBaCmV9Wmt
         wtB2zxMu2ZQGg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210201151245.21845-5-alexandru.ardelean@analog.com>
References: <20210201151245.21845-1-alexandru.ardelean@analog.com> <20210201151245.21845-5-alexandru.ardelean@analog.com>
Subject: Re: [PATCH v3 4/4] clk: axi-clkgen: use devm_platform_ioremap_resource() short-hand
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, lars@metafoo.de,
        linux-fpga@vger.kernel.org, mdf@kernel.org, ardeleanalex@gmail.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 08 Feb 2021 18:29:56 -0800
Message-ID: <161283779689.76967.6432716639461896118@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Quoting Alexandru Ardelean (2021-02-01 07:12:45)
> No major functional change. Noticed while checking the driver code that
> this could be used.
> Saves two lines.
>=20
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---

Applied to clk-next
