Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F8440D57C;
	Wed, 24 Jun 2026 05:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278498; cv=none; b=SxSrUrf9YL2rpAJPC1j2PkekBTEEhRTmsf2MB2M77/49hOKdhDcsn9vOCrQG462RyPKKA50VJ8tk/JDQf+TdJEuG6Nc7PxcbNRwKZJWG2M1OlB/NawatN2SCTWF5zhw0PfY6sqcm8kJfAHWozZijzdraCZm06TCiOayxR+qxMAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278498; c=relaxed/simple;
	bh=dWOiyPw8SwzuaCpopifxgxeC8fPGRqTXhod92zUNqm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btCJlyi5Z8Vua4hwyziYPaRfRGhlb1eEnJCNmnCQM5JqmmHIks13ODFJl+5IbPal47u0pO6xRXWpXg3sAw0RtGidVaNANEBtaTRyXKZb/DaY8WuC44mWH/lV9+DLFj2s24FCCfdkAFI4LDZoLyuju6a43+2BJ0eC9so7bn45v/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tf8i/g9o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tf8i/g9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9321F000E9;
	Wed, 24 Jun 2026 05:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782278497;
	bh=6MU8hKYNCX/KiSjEVrqQt88f8Wsf5o2Em5/a/kv+aBk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Tf8i/g9o3HZHD47ptFfKbux4DEEmPjTcT0iGoV83naFevVPRNsjlgsaD+WJbVE6XE
	 C+qvOPVZkOhgZyEEBClXPSzR9l6j2mzIxqw47I+CtV1/0UGAQAXtQEjeM8C3Pzo0uS
	 yYGFSXHy/SzKMbWPBKif4a99li8hj8J8fKDRv4Av9HZcrvOlZNNB7LnY0hhD6STPIj
	 ZyslboSFF+nUyGQ/TdYaU5xLLhaeJ7CCCLvWHVfhZatGR3LFZVmtWgXkztefd241rq
	 jdn2PvSpUcR2z2ipxRV8JZoNRUjCyPMGCU7iF2sDhyQVkwxOJUPVOoCHfqCCCm71ZG
	 dPu1yHDNx9dJg==
Message-ID: <c7ad6ead-c60f-42c4-ba3c-98930e660d42@kernel.org>
Date: Wed, 24 Jun 2026 00:21:35 -0500
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fpga: stratix10-soc: Fix SVC mailbox handling during
 reconfiguration
Content-Language: en-US
To: tze.yee.ng@altera.com, Moritz Fischer <mdf@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Richard Gong <richard.gong@intel.com>, Alan Tull <atull@kernel.org>,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tien.sung.ang@altera.com
References: <b019a8ba0b0c30b0bc19719386a46d47df3141b3.1782271444.git.tze.yee.ng@altera.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <b019a8ba0b0c30b0bc19719386a46d47df3141b3.1782271444.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/23/26 22:37, tze.yee.ng@altera.com wrote:
> From: Tien Sung Ang <tien.sung.ang@altera.com>
> 
> Fix incorrect stratix10_svc_done() usage during FPGA reconfiguration.
> 
> Do not call stratix10_svc_done() at the end of write_init() on success, so
> the SVC session remains active through write() and write_complete(). Call
> stratix10_svc_done() on failure in write_init() and write() so the shared
> SVC mailbox is released when reconfiguration aborts, allowing coexistence
> with other SVC clients such as soc64-hwmon.
> 
> Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
> Cc: stable@vger.kernel.org # 5.1+
> 

Remove the blank line.
> Signed-off-by: Tien Sung Ang <tien.sung.ang@altera.com>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>

