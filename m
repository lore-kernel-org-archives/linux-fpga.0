Return-Path: <SRS0=Q6nU=DL=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC19C4363C
	for <linux-fpga@archiver.kernel.org>; Sun,  4 Oct 2020 23:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE3EE206DD
	for <linux-fpga@archiver.kernel.org>; Sun,  4 Oct 2020 23:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601854810;
	bh=spBak83gFftgm+yi3RhrYvzm6iNkft5xvwLmO6ZkIeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gCpSeIt4DIbj9yj1FREIze+r01TWJHyUr9Ze3Aa5JUnhpDO/2ZPk9g+7vdkGYLo+D
	 3w2f4IIhiLs0pT33GAcHA/i8yL8R3YrPYwa30zewqxWO31yz9zf7DM6hWpsnGOhkG3
	 b8PXPxy8uN49MtCAQY5H9iA3SNtgnyHQu9BFTtT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgJDXkK (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Sun, 4 Oct 2020 19:40:10 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36736 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgJDXkK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 19:40:10 -0400
Received: by mail-pj1-f66.google.com with SMTP id b17so4305400pji.1;
        Sun, 04 Oct 2020 16:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5RmC8lajvDc8JqqhpPvdF9cVFad8GQY7C5ZedFzF2D4=;
        b=JmxdNQntLN03I9Vcw9bZquYFA74wnb16vYw/UpL7TNZsZjFLB5d0GJ21B9WtGYG0Yv
         ZzARxCk6RqDIzFHfWooVWsBQezDB6RDexwbzBkWx0n8iFllsOnwIagtvL5qV8t/M40Qc
         roPflBYqYR/+MGaVKjYrJm0Izn8n7/LMgiXKeyQH5ZkkXlqnFwBx08ouSr2a/EB4NWBa
         OcUwpjdedVhnW7T6q2gJiRRm9VNf73/LGAWhKGV/T9pZ7mN1jSA4tDOQ+B/MNOV9JDHC
         r1eg5jrzthUuWyjYyFrch4flqsNpWLsR/eIPoyVoVQgXZ+jfnAbuOY4T7pogfMmBKKiu
         t/Fw==
X-Gm-Message-State: AOAM531OMo5tDAEMsMBE9gox9hcjNFqz7lAqqRXX3e0Qs+zN54MfKra8
        pmZfB4vt8qYwudOGGurtMNI=
X-Google-Smtp-Source: ABdhPJwzpONdJUJJVy488Qvmo0+TrrapgrC7zUxvxXWZByizaGqJE/ZtWk2CB+oYu7/wLlyCfnG5JA==
X-Received: by 2002:a17:90a:aa05:: with SMTP id k5mr13402380pjq.59.1601854809620;
        Sun, 04 Oct 2020 16:40:09 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id x22sm7652583pfp.181.2020.10.04.16.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 16:40:09 -0700 (PDT)
Date:   Sun, 4 Oct 2020 16:40:08 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH 03/10] fpga: fpga-mgr: dfl-fme-mgr: Simplify registration
Message-ID: <20201004234008.GB111357@epycbox.lan>
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-4-mdf@kernel.org>
 <408267d9-1026-1a80-56c9-3a8beaaa2b82@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408267d9-1026-1a80-56c9-3a8beaaa2b82@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Oct 04, 2020 at 11:22:31AM -0700, Tom Rix wrote:
> 
> On 10/3/20 10:14 PM, Moritz Fischer wrote:
> > Simplify registration using new devm_fpga_mgr_register() API.
> >
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  drivers/fpga/dfl-fme-mgr.c | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> > index b3f7eee3c93f..3fc2be87d059 100644
> > --- a/drivers/fpga/dfl-fme-mgr.c
> > +++ b/drivers/fpga/dfl-fme-mgr.c
> > @@ -316,16 +316,7 @@ static int fme_mgr_probe(struct platform_device *pdev)
> >  	mgr->compat_id = compat_id;
> >  	platform_set_drvdata(pdev, mgr);
> 
Nice catch. Will fix.
> Is this call is still needed ?
> 
> Tom
> 
> >  
> > -	return fpga_mgr_register(mgr);
> > -}
> > -
> > -static int fme_mgr_remove(struct platform_device *pdev)
> > -{
> > -	struct fpga_manager *mgr = platform_get_drvdata(pdev);
> > -
> > -	fpga_mgr_unregister(mgr);
> > -
> > -	return 0;
> > +	return devm_fpga_mgr_register(dev, mgr);
> >  }
> >  
> >  static struct platform_driver fme_mgr_driver = {
> > @@ -333,7 +324,6 @@ static struct platform_driver fme_mgr_driver = {
> >  		.name    = DFL_FPGA_FME_MGR,
> >  	},
> >  	.probe   = fme_mgr_probe,
> > -	.remove  = fme_mgr_remove,
> >  };
> >  
> >  module_platform_driver(fme_mgr_driver);
> 

Cheers,
Moritz
