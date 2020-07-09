Return-Path: <SRS0=/qFs=AU=redhat.com=trix@kernel.org>
Return-Path: <SRS0=/qFs=AU=redhat.com=trix@kernel.org>
Subject: Re: [RESEND PATCH 1/2] fpga: dfl: pci: reduce the scope of variable
 'ret'
References: <1594282337-32125-1-git-send-email-yilun.xu@intel.com>
 <1594282337-32125-2-git-send-email-yilun.xu@intel.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <ef506ec6-d857-736b-e9e2-46077ab7d778@redhat.com>
Date: Thu, 9 Jul 2020 06:18:18 -0700
MIME-Version: 1.0
In-Reply-To: <1594282337-32125-2-git-send-email-yilun.xu@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lgoncalv@redhat.com
List-ID: <linux-fpga@vger.kernel.org>

I think a better change is to use the ret variable, like this

--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -312,7 +312,7 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
                }
        }
 
-       return num_vfs;
+       return ret;
 }

The existing use of returning num_vfs is not right, the function should return 0/err not num_vfs. currently it is reusing the 0 passed in with num_vfs to mean disable as the 0 return status.  it should be properly returning ret.

Tom

On 7/9/20 1:12 AM, Xu Yilun wrote:
> This is to fix lkp cppcheck warnings:
>
>  drivers/fpga/dfl-pci.c:230:6: warning: The scope of the variable 'ret' can be reduced. [variableScope]
>     int ret = 0;
>         ^
>
>  drivers/fpga/dfl-pci.c:230:10: warning: Variable 'ret' is assigned a value that is never used. [unreadVariable]
>     int ret = 0;
>             ^
>
> Fixes: 3c2760b78f90 ("fpga: dfl: pci: fix return value of cci_pci_sriov_configure")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/dfl-pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 4a14a24..73b5153 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -285,7 +285,6 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
>  {
>  	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
>  	struct dfl_fpga_cdev *cdev = drvdata->cdev;
> -	int ret = 0;
>  
>  	if (!num_vfs) {
>  		/*
> @@ -297,6 +296,8 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
>  		dfl_fpga_cdev_config_ports_pf(cdev);
>  
>  	} else {
> +		int ret;
> +
>  		/*
>  		 * before enable SRIOV, put released ports into VF access mode
>  		 * first of all.
