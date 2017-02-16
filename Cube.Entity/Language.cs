//------------------------------------------------------------------------------
// File Name   : Language.cs
// Creator     : John.ZC.Zhuang
// Create Date : 2017-02-14
// Description : 此代码由工具生成，请不要人为更改代码，如果重新生成代码后，这些更改将会丢失。
// Copyright (C) 2017 Qisda Corporation. All rights reserved.
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using ITS.Data;
using ITS.Data.Common;

namespace Cube.Entity
{

	/// <summary>
	/// 实体类Language
	/// </summary>
	[Serializable]
	public class Language : ITS.Data.EntityBase
	{
		public Language():base("language") {}

		#region Model
		private Guid _Id;
		private string _Lang_Key;
		private string _Zh_Cn;
		private string _Zh_Tw;
		private string _En_Us;
		/// <summary>
		/// 
		/// </summary>
		public Guid Id
		{
			get{ return _Id; }
			set
			{
				this.OnPropertyValueChange(_.Id,_Id,value);
				this._Id=value;
			}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Lang_Key
		{
			get{ return _Lang_Key; }
			set
			{
				this.OnPropertyValueChange(_.Lang_Key,_Lang_Key,value);
				this._Lang_Key=value;
			}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Zh_Cn
		{
			get{ return _Zh_Cn; }
			set
			{
				this.OnPropertyValueChange(_.Zh_Cn,_Zh_Cn,value);
				this._Zh_Cn=value;
			}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Zh_Tw
		{
			get{ return _Zh_Tw; }
			set
			{
				this.OnPropertyValueChange(_.Zh_Tw,_Zh_Tw,value);
				this._Zh_Tw=value;
			}
		}
		/// <summary>
		/// 
		/// </summary>
		public string En_Us
		{
			get{ return _En_Us; }
			set
			{
				this.OnPropertyValueChange(_.En_Us,_En_Us,value);
				this._En_Us=value;
			}
		}
		#endregion

		#region Method
		/// <summary>
		/// 获取实体中的主键列
		/// </summary>
		public override Field[] GetPrimaryKeyFields()
		{
			return new Field[] {
				_.Id};
		}
		/// <summary>
		/// 获取列信息
		/// </summary>
		public override Field[] GetFields()
		{
			return new Field[] {
				_.Id,
				_.Lang_Key,
				_.Zh_Cn,
				_.Zh_Tw,
				_.En_Us};
		}
		/// <summary>
		/// 获取值信息
		/// </summary>
		public override object[] GetValues()
		{
			return new object[] {
				this._Id,
				this._Lang_Key,
				this._Zh_Cn,
				this._Zh_Tw,
				this._En_Us};
		}
		/// <summary>
		/// 给当前实体赋值
		/// </summary>
		public override void SetPropertyValues(IDataReader reader)
		{
			this._Id = DataUtils.ConvertValue<Guid>(reader["id"]);
			this._Lang_Key = DataUtils.ConvertValue<string>(reader["lang_key"]);
			this._Zh_Cn = DataUtils.ConvertValue<string>(reader["zh_cn"]);
			this._Zh_Tw = DataUtils.ConvertValue<string>(reader["zh_tw"]);
			this._En_Us = DataUtils.ConvertValue<string>(reader["en_us"]);
		}
		/// <summary>
		/// 给当前实体赋值
		/// </summary>
		public override void SetPropertyValues(DataRow row)
		{
			this._Id = DataUtils.ConvertValue<Guid>(row["id"]);
			this._Lang_Key = DataUtils.ConvertValue<string>(row["lang_key"]);
			this._Zh_Cn = DataUtils.ConvertValue<string>(row["zh_cn"]);
			this._Zh_Tw = DataUtils.ConvertValue<string>(row["zh_tw"]);
			this._En_Us = DataUtils.ConvertValue<string>(row["en_us"]);
		}
		#endregion

		#region _Field
		/// <summary>
		/// 字段信息
		/// </summary>
		public class _
		{
			/// <summary>
			/// * 
			/// </summary>
			public readonly static Field All = new Field("*","language");
			/// <summary>
			/// 
			/// </summary>
			public readonly static Field Id = new Field("id","language",DbType.Guid,16,"id");
			/// <summary>
			/// 
			/// </summary>
			public readonly static Field Lang_Key = new Field("lang_key","language",DbType.AnsiString,250,"lang_key");
			/// <summary>
			/// 
			/// </summary>
			public readonly static Field Zh_Cn = new Field("zh_cn","language",DbType.String,16,"zh_cn");
			/// <summary>
			/// 
			/// </summary>
			public readonly static Field Zh_Tw = new Field("zh_tw","language",DbType.String,16,"zh_tw");
			/// <summary>
			/// 
			/// </summary>
			public readonly static Field En_Us = new Field("en_us","language",DbType.String,16,"en_us");
		}
		#endregion


	}
}

