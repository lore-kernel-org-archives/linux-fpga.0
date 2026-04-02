Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378092D47F1;
	Thu,  2 Apr 2026 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145824; cv=none; b=UtbrH2+RH7HHP1F+LmNdDhfjEsmA7JZ6VjsherWkjkzTRJAVAvI7VpCHqQf9xZMCSE38+1cVWrCJA/YHSX7ETwfp66VPuV4/SBZ5Rw0bZHLg8VJMRhWLMqvgAVHrct0TgDS5BQGbHKncomGkRz2cViulu+uLA3eE6Zxk7AlHSFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145824; c=relaxed/simple;
	bh=7s0FCBwPiK9ZKXXZdjHXWa/K+jGeNaF4H9YU4zoPjRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQJTPMTW58PIgyQEc+Et+3nsgWg9oUP05HBud8M7n2D7aWeD5eGsggTUmlAs3tW7am3dDow+pg5PA2HiWd3z5tRaIaz5xx+4DYofQsj8ZpG5ImUxA60Kl9elBBLSAdyPD3HdiRNM4d/SsjE/secC5yh90O7zh8H/qTtcshZ3HNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZGJi8eZB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZGJi8eZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C790C116C6;
	Thu,  2 Apr 2026 16:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775145823;
	bh=7s0FCBwPiK9ZKXXZdjHXWa/K+jGeNaF4H9YU4zoPjRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZGJi8eZBK6qnty3rzYF0ewmxO/bQ+pG70FhrUMXH/YYSgYAxxHnQ+med6E79iXyqB
	 hQgXxI6ZJqbVor6DgOEZ/KEDcbl7vjbLKQrPaJcST/MHcehak8D1z1Ivqpm/VqpNMy
	 1V1mqn2RzXSWFyc6yneB98ZhzKNTGmbLtpdygfb0=
Date: Thu, 2 Apr 2026 18:03:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: linux-fpga@vger.kernel.org, yilun.xu@linux.intel.com,
	conor.dooley@microchip.com, mdf@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] fpga: microchip-spi: add bounds checks in
 mpf_ops_parse_header()
Message-ID: <2026040223-quilt-astute-d24c@gregkh>
References: <20260402125446.3776153-3-sebasjosue84@gmail.com>
 <20260402153752.3793055-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402153752.3793055-1-sebasjosue84@gmail.com>

On Thu, Apr 02, 2026 at 09:37:52AM -0600, Sebastian Alba Vives wrote:
> From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
> 
> mpf_ops_parse_header() reads several fields from the bitstream file
> and uses them as offsets and sizes without validating them against the
> buffer size, leading to multiple out-of-bounds read vulnerabilities:
> 
> 1. There is no check that count is large enough to read header_size
>    at MPF_HEADER_SIZE_OFFSET (24). Add a minimum count check.
> 
> 2. When header_size (u8 from file) is 0, the expression
>    *(buf + header_size - 1) reads one byte before the buffer.
>    Return -EINVAL since retrying with a larger buffer cannot fix
>    a zero header_size.
> 
> 3. In the block lookup loop, block_id_offset and block_start_offset
>    advance by MPF_LOOKUP_TABLE_RECORD_SIZE (9) each iteration with
>    blocks_num (u8) controlling the count. With a small buffer, these
>    offsets exceed count, causing OOB reads via get_unaligned_le32().
>    Return -EAGAIN since a larger buffer may resolve the issue.
> 
> 4. components_size_start (from file) and component_size_byte_num
>    (derived from components_num, u16 from file) are used as offsets
>    into buf without validation, allowing arbitrary OOB reads.
> 
> Add bounds checks for all four cases.
> 
> Fixes: 5f8d4a9008307 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> ---
>  drivers/fpga/microchip-spi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> index 6134cea..00fa2d6 100644
> --- a/drivers/fpga/microchip-spi.c
> +++ b/drivers/fpga/microchip-spi.c
> @@ -115,7 +115,13 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
>  		return -EINVAL;
>  	}
>  
> +	if (count < MPF_HEADER_SIZE_OFFSET + 1)
> +		return -EINVAL;
> +
>  	header_size = *(buf + MPF_HEADER_SIZE_OFFSET);
> +	if (!header_size)
> +		return -EINVAL;
> +
>  	if (header_size > count) {
>  		info->header_size = header_size;
>  		return -EAGAIN;
> @@ -139,6 +145,10 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
>  	bitstream_start = 0;
>  
>  	while (blocks_num--) {
> +		if (block_id_offset >= count ||
> +		    block_start_offset + sizeof(u32) > count)
> +			return -EAGAIN;
> +
>  		block_id = *(buf + block_id_offset);
>  		block_start = get_unaligned_le32(buf + block_start_offset);
>  
> @@ -183,6 +193,10 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
>  		component_size_byte_off =
>  			(i * MPF_BITS_PER_COMPONENT_SIZE) % BITS_PER_BYTE;
>  
> +		if (components_size_start + component_size_byte_num +
> +		    sizeof(u32) > count)
> +			return -EINVAL;
> +
>  		component_size = get_unaligned_le32(buf +
>  						    components_size_start +
>  						    component_size_byte_num);
> -- 
> 2.43.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
