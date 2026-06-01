Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6883E0224
	for <linux-fpga@vger.kernel.org>; Mon,  1 Jun 2026 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336640; cv=none; b=CyxE0vih3fU6FGyfyTC8g4KqLrCWHNfMZQE9pd/N4vFPuC1tJujDv4VZaa+b0TulXRHvWcSjmNa1z9ZOJujD3tcfKLRJ/iVlE5MIG676t7Q0gJ+zy3t7z6dWmTQ38zXvQAas8D8yKRfPv5L5AqsRzvCWWehb1wF7AXq0RUHPmQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336640; c=relaxed/simple;
	bh=a8NNwl3gj28TdelJ2QDDl+HZA18Xikw2b26A8/RV0gM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcfCCXCg6cEKiIzrldz2FrrcHWVt9W6xhhk4VE/9N5ePmttpEkRFU3ouKxn21PvMTRfZ/ldc9WBuwhcmIfWJnEBD7OpoGDqAm3nlpz21tIV1bFIW7xv4Km3ZNGZuhCV4IrV+2S4SE0fg5CyomJ1lbshCNZ/R5fpBbkCglE73rGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEzYjb2k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEzYjb2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32D31F00A28
	for <linux-fpga@vger.kernel.org>; Mon,  1 Jun 2026 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780336638;
	bh=Fs6zIa+oKHWvRltzPvd2mFdEu12rLJwaXHbNCVd0THk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VEzYjb2k+jXMAhXQHyz+v1BrlB+2//Wyn8yllWfB2zFKWK+4vx8+YpVCQ1MLYNWmK
	 ZE+21JPsbTNbsRuE1E34fR/KspMOCQ0kqXiQIV5QcRvQkc6CNrnswoB6+YdEUx+wjf
	 p/WvlAgPKW6j2CfAkywRPXEZVq/ZFHEZe9giPPkTHL0ZFodjL5I+d2L4e8lpuL21Kb
	 ZMrZK20p1Z0Dbh1AC2efSJgFlH3JwZqN0jJFunYIA5MG7fpt9RbYKYYMvIpcTNxfsW
	 XIWTqyeyXmxo8sES1fTCK4csLl5R5UzbXAunA7JTIwnbWMTa4fAF5qwKZuNH/eJpLR
	 07Jdz5Hevn5gw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa66893e9fso1831670e87.1
        for <linux-fpga@vger.kernel.org>; Mon, 01 Jun 2026 10:57:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8lXdqxsNLcg1uuOhKsWbygUQ40Fe9jqnYZWE/QKrZ+57GqF9SqtdC83jxbpyctsINHpiiwHAN2IB8Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/AuC2zgxsuumLVU8xWlpD+q3ZlSTix6kGLNOFiaYKQMmKfh2h
	dUMSGpyDbjnBVQiarJpQYmT1Blw3OJwIoyLrywvSGNlSMRT+E4IaT5SAwfYSz4IgzNgv24ATZWZ
	xJBT7RrnxgD7ocDKJSZvJ8zH/2v0+aYQ=
X-Received: by 2002:a05:6512:8007:20b0:5aa:6395:f9c5 with SMTP id
 2adb3069b0e04-5aa73ee8720mr300250e87.27.1780336637107; Mon, 01 Jun 2026
 10:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528183625.870813-1-ynorov@nvidia.com> <20260528183625.870813-15-ynorov@nvidia.com>
In-Reply-To: <20260528183625.870813-15-ynorov@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jun 2026 19:57:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g4G9aJ1fjQxXmk1YHXh+xBojpFz207j_jz7HiLH1Lz1Q@mail.gmail.com>
X-Gm-Features: AVHnY4INVXbw7SKAZHG4Jnm8fXAHVwo_FKl3cnkJN8dTeVudl-a8v97e8VxcFA4
Message-ID: <CAJZ5v0g4G9aJ1fjQxXmk1YHXh+xBojpFz207j_jz7HiLH1Lz1Q@mail.gmail.com>
Subject: Re: [PATCH 14/16] powercap: intel_rapl: Use sysfs_emit() for cpumask show
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Heiko Stuebner <heiko@sntech.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Moritz Fischer <mdf@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jic23@kernel.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Will Deacon <will@kernel.org>, 
	Jiucheng Xu <jiucheng.xu@amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Linu Cherian <lcherian@marvell.com>, Gowthami Thiagarajan <gthiagarajan@marvell.com>, 
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Khuong Dinh <khuong@os.amperecomputing.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Besar Wicaksono <bwicaksono@nvidia.com>, 
	Ma Ke <make24@iscas.ac.cn>, Chengwen Feng <fengchengwen@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-fpga@vger.kernel.org, 
	linux-rdma@vger.kernel.org, nvdimm@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-cxl@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 8:37=E2=80=AFPM Yury Norov <ynorov@nvidia.com> wrot=
e:
>
> cpumask_show() is a sysfs show callback. Use sysfs_emit() and
> cpumask_pr_args() to emit the mask.
>
> This prepares for removing cpumap_print_to_pagebuf().
>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index a8dd02dff0a0..b38d4a7799a8 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1441,7 +1441,7 @@ static ssize_t cpumask_show(struct device *dev,
>         }
>         cpus_read_unlock();
>
> -       ret =3D cpumap_print_to_pagebuf(true, buf, cpu_mask);
> +       ret =3D sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_mask));
>
>         free_cpumask_var(cpu_mask);
>
> --

Applied (with adjusted subject and changelog) as 7.2 material, thanks!
