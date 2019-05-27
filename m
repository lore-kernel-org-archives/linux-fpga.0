Return-Path: <SRS0=W/v2=T3=bwidawsk.net=ben@kernel.org>
Return-Path: <SRS0=W/v2=T3=bwidawsk.net=ben@kernel.org>
Date: Mon, 27 May 2019 15:03:12 -0700
From: Ben Widawsky <ben@bwidawsk.net>
Subject: Re: [PATCH -next] fpga: dfl: afu: Remove set but not used variable
 'afu'
Message-ID: <20190527220312.etjg7efr2uekvtqh@mail.bwidawsk.net>
References: <20190527153755.7332-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527153755.7332-1-yuehaibing@huawei.com>
To: YueHaibing <yuehaibing@huawei.com>
Cc: hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 19-05-27 23:37:55, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/fpga/dfl-afu-main.c: In function afu_dev_destroy:
> drivers/fpga/dfl-afu-main.c:529:18: warning: variable afu set but not used [-Wunused-but-set-variable]
> 
> It is never used since introduction in commit
> 857a26222ff7 ("fpga: dfl: afu: add afu sub feature support")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Ben Widawsky <ben@bwidawsk.net>
