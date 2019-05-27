Return-Path: <SRS0=W/v2=T3=bwidawsk.net=ben@kernel.org>
Return-Path: <SRS0=W/v2=T3=bwidawsk.net=ben@kernel.org>
Date: Mon, 27 May 2019 15:02:58 -0700
From: Ben Widawsky <ben@bwidawsk.net>
Subject: Re: [PATCH -next] fpga: dfl: fme: Remove set but not used variable
 'fme'
Message-ID: <20190527220258.jcbqfww4mxnhee3v@mail.bwidawsk.net>
References: <20190527153424.10268-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527153424.10268-1-yuehaibing@huawei.com>
To: YueHaibing <yuehaibing@huawei.com>
Cc: hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 19-05-27 23:34:24, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/fpga/dfl-fme-main.c: In function fme_dev_destroy:
> drivers/fpga/dfl-fme-main.c:216:18: warning: variable fme set but not used [-Wunused-but-set-variable]
> 
> It's never used since introduction in commit 29de76240e86 ("fpga:
> dfl: fme: add partial reconfiguration sub feature support")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Ben Widawsky <ben@bwidawsk.net>

[snip]
