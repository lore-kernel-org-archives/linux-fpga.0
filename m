Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD443859E9;
	Thu, 23 Jul 2026 04:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782099; cv=none; b=rbAC2H+c/BBfA7J5AyjzfLsz9r/+F/XXh3nL7hv+fNDgs+4svnjHjZffIvqtjM+IyETQmDpf6pWCqHSns4yyJe8jhyBOE7dtf6Pev2V4UmRoofKErUSO34D6IfR0OTd7PWbjNc4++yE4pFLqq1nTZzGknoevXv3NU/pWPU6Dxes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782099; c=relaxed/simple;
	bh=hacmWLs3ODWCH/rl9eIxaL2Qvwvwwc2JbyNCjZfyblY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGV5Tfrxqn0nihqMnolKR4ZfA4ORH1D4crlEaix5kTXsry3qV08lCTcKzXIWLd0Op2mJza3YTvGE4Ul30AgLXe+/iBz6krgbraVbg7gLtk0WCFDA1GHHtZNPvrR0C7sB7oubL6R6AJfgR5Cl9MRott6O48g987k2SM4wI85A5oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=aJO93URX; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="aJO93URX"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5782E11AF26;
	Thu, 23 Jul 2026 06:47:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784782073;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=tmgyHk6loOLo2xFly+bTdBXTfayYJvruU03nKY/rO4k=;
	b=aJO93URXK63r7gBQTWR5JyNICiyYIxrp7Wqf20fWRrLXz8FM5JjUM3yFLnU02+o5BxHhAB
	zTqNqLfc/x01qimvxrcx6R5NdniXq70o82xWH+MipwrvCLZhrWgnkmbErdXIbAXJN9xzQo
	PFP6PyfusspfW5cKxwdtJCu31bNWoxt3Geaa1R2CCp3NpFUYY06pRwRPA0ZoABRTFaiL9R
	urrlpG1QK4rOJTlEuN2S72+p0X0UwD+gVEH40iSOYhYyz1pSwreSPJjj2+gG50iXVqEXCq
	naZLHOkflGhzFrZ0KTPsczSBuE3KlojWvs0wP3xMmYgGz/XKJpnZpTpqIZefeA==
Message-ID: <d7844d5d-1ce5-2b31-64ca-4ff2798ce221@nabladev.com>
Date: Thu, 23 Jul 2026 06:47:22 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] driver: fpga: xilinx-selectmap: add csi and rdwr
 support
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Michal Simek <michal.simek@amd.com>,
 Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
 Xu Yilun <yilun.xu@intel.com>
References: <20260721114258.3324794-1-hs@nabladev.com>
 <amGbvtMWHXjpE35D@yilunxu-OptiPlex-7050>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <amGbvtMWHXjpE35D@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Yilun,

On 23.07.26 06:42, Xu Yilun wrote:
> On Tue, Jul 21, 2026 at 01:42:52PM +0200, Heiko Schocher wrote:
>> Add csi_b and rdwr pin support for the xilinx,selectmap driver.
>>
>> In current driver the pins are configured from DTS and set to
>> GPIOD_OUT_HIGH. This works in case you have one FPGA.
>>
>> Extend this to really implement csi_b and rdwr pin function in
>> driver, so it works with more than one FPGA.
> 
> Please help specify in changelog: what do csi_b, rdwr pins do? Why they
> now work with one FPGA but not with 2 FPGAs? How do you select which FPGA
> to reprogram? thanks.

I will try to add this. You find some hint here:

Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml

Thanks!

bye,
Heiko
> 
> Thanks,
> Yilun
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
