<?php
/**
 * 标签输出
 *
 * @category typecho
 * @package Widget
 * @copyright Copyright (c) 2008 Typecho team (http://www.typecho.org)
 * @license GNU General Public License 2.0
 * @version $Id$
 */

/**
 * 分类输出组件
 *
 * @category typecho
 * @package Widget
 * @copyright Copyright (c) 2008 Typecho team (http://www.typecho.org)
 * @license GNU General Public License 2.0
 */
class Widget_Metas_Tag_List extends Widget_Abstract_Metas
{
    /**
     * 执行函数
     *
     * @access public
     * @return void
     */
    public function execute()
    {
        $this->parameter->setDefault(array('sort' => 'count', 'ignoreZeroCount' => false, 'desc' => true, 'limit' => 0));
        $select = $this->select()->where('type = ?', 'tag')->order($this->parameter->sort,
        $this->parameter->desc ? Typecho_Db::SORT_DESC : Typecho_Db::SORT_ASC);

        /** 忽略零数量 */
        if ($this->parameter->ignoreZeroCount) {
            $select->where('count > 0');
        }

        /** 总数限制 */
        if ($this->parameter->limit) {
            $select->limit($this->parameter->limit);
        }

        $list = $this->db->fetchAll($select);
        foreach ($list as $key => $value) {
            $list[$key]['rand'] = rand(0,5);
            call_user_func(array(&$this, 'push'), $list[$key]);
        }
    }
}
