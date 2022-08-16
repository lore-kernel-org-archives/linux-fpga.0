Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50362C2BB41
	for <linux-fpga@archiver.kernel.org>; Tue, 16 Aug 2022 09:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiHPJ0U (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Tue, 16 Aug 2022 05:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiHPJZx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 16 Aug 2022 05:25:53 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5422D12D05;
        Tue, 16 Aug 2022 00:42:19 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 3553160763;
        Tue, 16 Aug 2022 09:42:17 +0200 (CEST)
Date:   Tue, 16 Aug 2022 09:42:16 +0200
From:   Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, mdf@kernel.org,
        hao.wu@intel.com, trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v6 1/2] fpga: ecp5-spi: add Lattice ECP5 FPGA manager
Message-ID: <20220816074216.GA31706@homes.emlix.com>
References: <20220815132157.8083-1-i.bornyakov@metrotek.ru>
 <20220815132157.8083-2-i.bornyakov@metrotek.ru>
 <Yvr6SY5WGXlYiLig@yilunxu-OptiPlex-7050>
 <20220816045841.irhr5vigemdqknaw@x260>
 <Yvs0jieXsyzhn8q9@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvs0jieXsyzhn8q9@yilunxu-OptiPlex-7050>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Aug 16, 2022 at 02:09:18PM +0800, Xu Yilun wrote:
> We don't have to make everything fine, but start with machxo2 and ecp5
> first. If the change affects machxo2, other people may help.

Programming MachXO* chips uses different sequences of commands. With ECP5
you put the chip into configuration mode and then upload the bitstream
into RAM cells. With MachXO chips you write the bitstream to non-volatile
storage and then tell the chip to go into configuration mode where it
automatically loads the bitstream from non-volatile storage. There is no
way to directly write the RAM cells.

Best regards,

  Daniel
