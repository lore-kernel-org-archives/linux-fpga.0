Return-Path: <SRS0=ClA7=SN=redhat.com=swood@kernel.org>
Return-Path: <SRS0=ClA7=SN=redhat.com=swood@kernel.org>
Message-ID: <f0c67ba35e963f61c05421f837bbf6b81be914a7.camel@redhat.com>
Subject: Re: [PATCH] fpga: dfl: Add lockdep classes for pdata->lock
From: Scott Wood <swood@redhat.com>
Date: Thu, 11 Apr 2019 10:17:21 -0500
In-Reply-To: <20190410215339.8074-1-swood@redhat.com>
References: <20190410215339.8074-1-swood@redhat.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Wu Hao <hao.wu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, 2019-04-10 at 16:53 -0500, Scott Wood wrote:
> @@ -443,11 +450,16 @@ static int build_info_commit_dev(struct
> build_feature_devs_info *binfo)
>  	struct platform_device *fdev = binfo->feature_dev;
>  	struct dfl_feature_platform_data *pdata;
>  	struct dfl_feature_info *finfo, *p;
> +	static enum dfl_id_type type;
>  	int ret, index = 0;

Ugh, not sure how that "static" snuck in there (probably copy-and-paste
error).  Will send v2.

-Scott
