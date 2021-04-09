Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F14C433B4
	for <linux-fpga@archiver.kernel.org>; Fri,  9 Apr 2021 14:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D36761185
	for <linux-fpga@archiver.kernel.org>; Fri,  9 Apr 2021 14:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhDIOsN (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Fri, 9 Apr 2021 10:48:13 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:35698 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhDIOsM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Apr 2021 10:48:12 -0400
Received: by mail-ot1-f45.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so5932897oto.2;
        Fri, 09 Apr 2021 07:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PYqFk0uyYuF7sf0uW4LvBh+bz3tdAG1Rgm/GvdKNnhs=;
        b=kAJzYGXNdilWJg6pAIs2E1D6M4U6b8l7N//mHmfPkQxAi8l0pWylKobyb00HON5qqg
         +nb/pG4kbRk+84TN7i8o+2nT7JGnUc+A/MQ3KLg8SdwB5sPVQ22t8ZE9b3zsfood98bt
         Gclb0gjFfVk4303+eTcPOHyzpuW0p00NX0hkob0HjfvTJek6KyJx7pwJT880hkIZcQK0
         WB13SXnae8Tl9O3NQolsXkTTWFh/LHB1j0SY6TzdfhX5xvZPNFN9RqU+W0uVgZxY4XhP
         m/UCZTyAxFjlYigMARPyzjO0YHK55eXNl+yW2vqIyoZWMvsrRj3hm4c0XQGYgqzPZoRI
         YiUQ==
X-Gm-Message-State: AOAM530RtOwXMt+gK/g0tXbJ0ld93qjnWmyABk6g61KADR2Jhzzjwska
        u/sVEk3lOb+XzYarLdn9jA==
X-Google-Smtp-Source: ABdhPJywCBz5UlEdqfbnotIV+V/czkYF4YLxLS/F2/KfnIBO2ues8v/QN3OE8e1fBS+sVMwJ+0Byfg==
X-Received: by 2002:a05:6830:1af6:: with SMTP id c22mr12012445otd.291.1617979678643;
        Fri, 09 Apr 2021 07:47:58 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d1sm635340oth.13.2021.04.09.07.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 07:47:58 -0700 (PDT)
Received: (nullmailer pid 3628624 invoked by uid 1000);
        Fri, 09 Apr 2021 14:47:57 -0000
Date:   Fri, 9 Apr 2021 09:47:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, devicetree@vger.kernel.org, git@xilinx.com,
        michal.simek@xilinx.com, robh+dt@kernel.org, trix@redhat.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: zynqmp: Add new PD_PL macro
Message-ID: <20210409144757.GA3628593@robh.at.kernel.org>
References: <20210402092049.479-1-nava.manne@xilinx.com>
 <20210402092049.479-2-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402092049.479-2-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, 02 Apr 2021 14:50:47 +0530, Nava kishore Manne wrote:
> Add new power domain for PL region.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  include/dt-bindings/power/xlnx-zynqmp-power.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
